#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# Dotfiles Bootstrap Script
# Cross-platform setup for Arch Linux and macOS
# =============================================================================

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GPG_KEY_ID="F3EB6A9821002B2C"

# GPG key and password-store are NOT in this repo for security
# They must be restored from Borg backup or provided manually
GPG_KEY_FILE=""  # Set via --gpg-key flag or prompt
PASSWORD_STORE_PATH="$HOME/.password-store"

# Track what we've done for summary
declare -a INSTALLED_PACKAGES=()
declare -a STOWED_PACKAGES=()

# =============================================================================
# Utility Functions
# =============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC} $*"; }
log_success() { echo -e "${GREEN}[OK]${NC} $*"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC} $*"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $*" >&2; }

command_exists() {
  command -v "$1" &>/dev/null
}

require_command() {
  if ! command_exists "$1"; then
    log_error "Required command not found: $1"
    return 1
  fi
}

# =============================================================================
# Platform Detection
# =============================================================================

OS_TYPE=""
ARCH_TYPE=""

detect_os() {
  case "$(uname -s)" in
    Linux*)
      OS_TYPE="linux"
      # Check if Arch Linux
      if [[ -f /etc/arch-release ]]; then
        log_info "Detected Arch Linux"
      else
        log_error "This script only supports Arch Linux on Linux systems"
        log_error "Detected: $(cat /etc/os-release 2>/dev/null | grep PRETTY_NAME | cut -d'"' -f2)"
        exit 1
      fi
      ;;
    Darwin*)
      OS_TYPE="macos"
      log_info "Detected macOS"
      ;;
    *)
      log_error "Unsupported operating system: $(uname -s)"
      exit 1
      ;;
  esac

  # Detect architecture (for Homebrew path on macOS)
  case "$(uname -m)" in
    arm64|aarch64)
      ARCH_TYPE="arm64"
      ;;
    x86_64)
      ARCH_TYPE="x86_64"
      ;;
    *)
      ARCH_TYPE="unknown"
      ;;
  esac
}

is_linux() { [[ "$OS_TYPE" == "linux" ]]; }
is_macos() { [[ "$OS_TYPE" == "macos" ]]; }

# =============================================================================
# Package Lists
# =============================================================================

PACMAN_CORE=(
  stow
  git
  zsh
  neovim
  fzf
  fd
  bat
  ripgrep
  direnv
  gnupg
  pass
  tree
  wget
  curl
  unzip
)

PACMAN_DEV=(
  nodejs
  npm
  python
  python-pip
  uv
)

PACMAN_DESKTOP=(
  i3-wm
  i3status
  i3lock
  picom
  polybar
  dunst
  rofi
  feh
  flameshot
  network-manager-applet
  brightnessctl
  pulseaudio
  pulseaudio-alsa
  pamixer
  alacritty
  xclip
  xorg-xrandr
  xorg-xinput
  dex
  polkit-gnome
)

PACMAN_HASKELL=(
  stack
  ghc
)

AUR_PACKAGES=(
  ghostty-git
  nerd-fonts-hack
  nerd-fonts-fira-code
  nerd-fonts-jetbrains-mono
  nerd-fonts-symbols-only
  gammastep
)

BREW_FORMULAE=(
  stow
  git
  zsh
  neovim
  fzf
  fd
  bat
  ripgrep
  direnv
  gnupg
  pass
  pinentry-mac
  tree
  wget
  curl
  node
  python
  uv
)

BREW_CASKS=(
  ghostty
  zed
  font-hack-nerd-font
  font-fira-code-nerd-font
  font-jetbrains-mono-nerd-font
  font-symbols-only-nerd-font
)

# =============================================================================
# Installation Functions
# =============================================================================

install_homebrew() {
  if command_exists brew; then
    log_info "Homebrew already installed"
    return 0
  fi

  log_info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add to PATH for this session
  if [[ "$ARCH_TYPE" == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  log_success "Homebrew installed"
}

install_yay() {
  if command_exists yay; then
    log_info "yay already installed"
    return 0
  fi

  log_info "Installing yay (AUR helper)..."
  local tmp_dir
  tmp_dir=$(mktemp -d)
  git clone https://aur.archlinux.org/yay.git "$tmp_dir/yay"
  (cd "$tmp_dir/yay" && makepkg -si --noconfirm)
  rm -rf "$tmp_dir"

  log_success "yay installed"
}

install_arch_packages() {
  log_info "Installing Arch Linux packages..."

  # Combine all pacman packages
  local all_pacman=("${PACMAN_CORE[@]}" "${PACMAN_DEV[@]}" "${PACMAN_DESKTOP[@]}" "${PACMAN_HASKELL[@]}")

  # Update package database and install
  sudo pacman -Syu --noconfirm
  sudo pacman -S --needed --noconfirm "${all_pacman[@]}"

  INSTALLED_PACKAGES+=("${all_pacman[@]}")
  log_success "Pacman packages installed"

  # Install AUR packages
  log_info "Installing AUR packages..."
  yay -S --needed --noconfirm "${AUR_PACKAGES[@]}"

  INSTALLED_PACKAGES+=("${AUR_PACKAGES[@]}")
  log_success "AUR packages installed"
}

install_macos_packages() {
  log_info "Installing macOS packages via Homebrew..."

  # Update Homebrew
  brew update

  # Install formulae
  brew install "${BREW_FORMULAE[@]}"

  # Install casks (including fonts)
  brew install --cask "${BREW_CASKS[@]}"

  INSTALLED_PACKAGES+=("${BREW_FORMULAE[@]}" "${BREW_CASKS[@]}")
  log_success "Homebrew packages installed"
}

# =============================================================================
# GPG & Password Store Setup
# =============================================================================

setup_gpg() {
  log_info "Setting up GPG..."

  # Ensure .gnupg exists with correct permissions
  mkdir -p "$HOME/.gnupg"
  chmod 700 "$HOME/.gnupg"

  # Check if key already imported
  if gpg --list-secret-keys "$GPG_KEY_ID" &>/dev/null; then
    log_info "GPG key $GPG_KEY_ID already imported"
    return 0
  fi

  # GPG key file not provided - prompt user
  if [[ -z "$GPG_KEY_FILE" ]] || [[ ! -f "$GPG_KEY_FILE" ]]; then
    log_warn "GPG private key not found"
    echo ""
    echo "Your GPG private key is required for password-store."
    echo "The key is NOT stored in this repo for security reasons."
    echo ""
    echo "Please provide the path to your GPG private key file:"
    echo "  - Restore from Borg backup, USB drive, or secure backup"
    echo "  - Then re-run: ./bootstrap.sh --gpg-key /path/to/key.asc"
    echo ""
    echo "To extract from Borg backup:"
    echo "  borg extract /mnt/synology/backups::ARCHIVE home/ryan/dotfiles/ryanbas21.priv.asc"
    echo ""
    log_warn "Skipping GPG setup - run again with --gpg-key flag"
    return 0
  fi

  # Import the private key (will prompt for passphrase)
  log_info "Importing GPG private key (you will be prompted for passphrase)..."
  gpg --import "$GPG_KEY_FILE"

  # Set trust level to ultimate
  log_info "Setting key trust level to ultimate..."
  echo "${GPG_KEY_ID}:6:" | gpg --import-ownertrust

  # Restart gpg-agent
  gpgconf --kill gpg-agent 2>/dev/null || true
  gpgconf --launch gpg-agent 2>/dev/null || true

  log_success "GPG key imported and trusted"
}

setup_password_store() {
  log_info "Setting up password store..."

  # Check if password store already exists and works
  if [[ -d "$PASSWORD_STORE_PATH" ]] && pass ls &>/dev/null; then
    log_success "Password store already configured and working"
    return 0
  fi

  # Check if it exists but GPG isn't set up yet
  if [[ -d "$PASSWORD_STORE_PATH" ]]; then
    log_info "Password store directory exists at $PASSWORD_STORE_PATH"
    if ! pass ls &>/dev/null; then
      log_warn "Password store exists but 'pass ls' failed - GPG key may not be imported yet"
    fi
    return 0
  fi

  # Password store doesn't exist - give instructions
  log_warn "Password store not found at $PASSWORD_STORE_PATH"
  echo ""
  echo "Your password store needs to be restored from Borg backup."
  echo ""
  echo "To restore from Borg backup on Synology:"
  echo "  1. Mount your Synology: sudo mount /mnt/synology"
  echo "  2. List available backups: borg list /mnt/synology/backups"
  echo "  3. Extract password store:"
  echo "     borg extract /mnt/synology/backups::ARCHIVE_NAME home/ryan/.password-store"
  echo "  4. Move to correct location: mv home/ryan/.password-store ~/"
  echo ""
  echo "Or initialize a new password store:"
  echo "  pass init $GPG_KEY_ID"
  echo ""
}

fix_gpg_pinentry() {
  if ! is_macos; then
    return 0
  fi

  log_info "Configuring GPG pinentry for macOS..."

  local gpg_agent_conf="$HOME/.gnupg/gpg-agent.conf"
  local pinentry_path

  # Determine pinentry-mac path based on architecture
  if [[ "$ARCH_TYPE" == "arm64" ]]; then
    pinentry_path="/opt/homebrew/bin/pinentry-mac"
  else
    pinentry_path="/usr/local/bin/pinentry-mac"
  fi

  # Check if pinentry-mac exists
  if [[ ! -x "$pinentry_path" ]]; then
    log_warn "pinentry-mac not found at $pinentry_path"
    return 0
  fi

  if [[ -f "$gpg_agent_conf" ]]; then
    # Replace pinentry-gnome3 with pinentry-mac
    if grep -q "pinentry-gnome3" "$gpg_agent_conf"; then
      sed -i.bak "s|pinentry-program /usr/bin/pinentry-gnome3|pinentry-program $pinentry_path|g" "$gpg_agent_conf"
      rm -f "${gpg_agent_conf}.bak"
      log_success "Updated gpg-agent.conf to use pinentry-mac"
    elif ! grep -q "pinentry-program" "$gpg_agent_conf"; then
      echo "pinentry-program $pinentry_path" >> "$gpg_agent_conf"
      log_success "Added pinentry-mac to gpg-agent.conf"
    fi
  else
    # Create new config for macOS
    cat > "$gpg_agent_conf" << EOF
pinentry-program $pinentry_path
default-cache-ttl 7200
max-cache-ttl 86400
EOF
    log_success "Created gpg-agent.conf with pinentry-mac"
  fi

  # Reload gpg-agent
  gpgconf --kill gpg-agent 2>/dev/null || true
}

# =============================================================================
# Stow Functions
# =============================================================================

CROSS_PLATFORM_PACKAGES=(
  nvim
  zshrc
  codex
  mcphub
  zed
)

LINUX_PACKAGES=(
  alacritty
  bin
  dunst
  gammastep
  ghostty
  gpg
  i3
  picom
  polybar
  rofi
  xmonad
)

LINUX_SYSTEM_PACKAGES=(
  etc
  systemd-etc
)

stow_package() {
  local pkg="$1"
  local target="${2:-$HOME}"
  local use_sudo="${3:-false}"

  if [[ ! -d "$DOTFILES_DIR/$pkg" ]]; then
    log_warn "Package directory not found: $pkg"
    return 0
  fi

  log_info "Stowing: $pkg -> $target"

  if [[ "$use_sudo" == "true" ]]; then
    sudo stow --verbose=1 --dir="$DOTFILES_DIR" --target="$target" "$pkg"
  else
    stow --verbose=1 --dir="$DOTFILES_DIR" --target="$HOME" "$pkg"
  fi

  STOWED_PACKAGES+=("$pkg")
}

stow_packages() {
  log_info "Stowing configuration packages..."

  # Cross-platform packages
  for pkg in "${CROSS_PLATFORM_PACKAGES[@]}"; do
    stow_package "$pkg"
  done

  if is_linux; then
    # Linux user packages
    for pkg in "${LINUX_PACKAGES[@]}"; do
      stow_package "$pkg"
    done

    # Linux system packages (require sudo, target /etc)
    log_info "Stowing system packages (requires sudo)..."
    for pkg in "${LINUX_SYSTEM_PACKAGES[@]}"; do
      stow_package "$pkg" "/etc" "true"
    done
  elif is_macos; then
    # On macOS, stow gpg but then fix pinentry
    stow_package "gpg"
    fix_gpg_pinentry
  fi

  log_success "All packages stowed"
}

# =============================================================================
# Post-Install Steps
# =============================================================================

set_default_shell() {
  local zsh_path

  if is_macos; then
    if [[ "$ARCH_TYPE" == "arm64" ]]; then
      zsh_path="/opt/homebrew/bin/zsh"
    else
      zsh_path="/usr/local/bin/zsh"
    fi

    # Homebrew zsh might not be in /etc/shells
    if ! grep -q "$zsh_path" /etc/shells; then
      log_info "Adding $zsh_path to /etc/shells"
      echo "$zsh_path" | sudo tee -a /etc/shells
    fi
  else
    zsh_path="/usr/bin/zsh"
  fi

  if [[ "$SHELL" == "$zsh_path" ]]; then
    log_info "zsh is already the default shell"
    return 0
  fi

  log_info "Setting zsh as default shell..."
  chsh -s "$zsh_path"
  log_success "Default shell changed to zsh (re-login required)"
}

trigger_plugin_installs() {
  # Neovim: lazy.nvim bootstraps automatically on first run
  if command_exists nvim; then
    log_info "Running Neovim headless to trigger lazy.nvim plugin install..."
    nvim --headless "+Lazy! sync" +qa 2>/dev/null || log_warn "Neovim plugin sync had issues - run nvim manually"
    log_success "Neovim plugins synced"
  fi

  # xmonad: needs Stack build (Linux only, run in background)
  if is_linux && command_exists stack; then
    local xmonad_dir="$HOME/.xmonad"
    if [[ -f "$xmonad_dir/stack.yaml" ]]; then
      log_info "Starting xmonad build in background (this takes 15-20 minutes on first run)..."
      log_info "Build log: $xmonad_dir/build.log"
      nohup bash -c "cd '$xmonad_dir' && stack build 2>&1" > "$xmonad_dir/build.log" 2>&1 &
      log_success "Xmonad build started in background (PID: $!)"
    fi
  fi

  log_info "Note: zplug will install shell plugins on first zsh session"
}

# =============================================================================
# Summary
# =============================================================================

print_summary() {
  echo ""
  echo -e "${GREEN}=== Bootstrap Complete ===${NC}"
  echo ""
  echo "Platform: $OS_TYPE ($ARCH_TYPE)"
  echo "Dotfiles: $DOTFILES_DIR"
  echo ""
  echo "Packages installed: ${#INSTALLED_PACKAGES[@]}"
  echo "Packages stowed: ${#STOWED_PACKAGES[@]}"
  echo ""

  if [[ ${#STOWED_PACKAGES[@]} -gt 0 ]]; then
    echo "Stowed packages:"
    for pkg in "${STOWED_PACKAGES[@]}"; do
      echo "  - $pkg"
    done
    echo ""
  fi

  echo "Next steps:"
  echo "  1. Log out and back in for shell change to take effect"
  echo "  2. Open a new terminal - zplug will install plugins"
  echo "  3. Open neovim - lazy.nvim will sync any remaining plugins"
  if is_linux; then
    echo "  4. Xmonad is building in background - check ~/.xmonad/build.log"
    echo "  5. Start i3 or xmonad via your display manager"
  fi
  echo ""
  echo "To verify setup:"
  echo "  gpg --list-secret-keys $GPG_KEY_ID"
  echo "  pass ls"
  echo ""
}

# =============================================================================
# Argument Parsing
# =============================================================================

usage() {
  cat << EOF
Usage: $(basename "$0") [OPTIONS]

Bootstrap dotfiles on a fresh Arch Linux or macOS system.

OPTIONS:
  --gpg-key PATH    Path to GPG private key file (.asc)
  --help            Show this help message

EXAMPLES:
  ./bootstrap.sh
  ./bootstrap.sh --gpg-key /path/to/key.asc
  ./bootstrap.sh --gpg-key /mnt/usb/ryanbas21.priv.asc

NOTES:
  - GPG key and password-store are NOT in this repo for security
  - Restore them from Borg backup before running, or provide --gpg-key
  - Password-store should be at ~/.password-store (restore from Borg)
EOF
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --gpg-key)
        if [[ -n "${2:-}" ]]; then
          GPG_KEY_FILE="$2"
          shift 2
        else
          log_error "--gpg-key requires a path argument"
          exit 1
        fi
        ;;
      --help|-h)
        usage
        exit 0
        ;;
      *)
        log_error "Unknown option: $1"
        usage
        exit 1
        ;;
    esac
  done
}

# =============================================================================
# Main
# =============================================================================

main() {
  echo -e "${BLUE}=== Dotfiles Bootstrap Script ===${NC}"
  echo "Repository: $DOTFILES_DIR"
  echo ""

  # 1. Detect platform
  detect_os

  # 2. Install package manager helpers
  if is_macos; then
    install_homebrew
  else
    install_yay
  fi

  # 3. Install packages
  if is_macos; then
    install_macos_packages
  else
    install_arch_packages
  fi

  # 4. Setup GPG
  setup_gpg

  # 5. Stow packages
  stow_packages

  # 6. Setup password store
  setup_password_store

  # 7. Set default shell
  set_default_shell

  # 8. Trigger plugin installs
  trigger_plugin_installs

  # 9. Print summary
  print_summary
}

# Parse arguments and run
parse_args "$@"
main
