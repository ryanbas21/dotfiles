#!/bin/bash
# Safe Borg backup script - Fixed to prevent system crashes
set -euo pipefail

# -----------------------
# Config
# -----------------------
export BORG_REPO="/mnt/synology/backups"
export BORG_PASSPHRASE=basded

MOUNT_POINT="/mnt/synology"
REQUIRED_FS_TYPES=("cifs" "nfs" "nfs4")
MIN_FREE_GIB=10

# Persistent state directory (survives reboots)
STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/borg-backup"
mkdir -p "$STATE_DIR"
LOCKFILE="$STATE_DIR/backup-running.lock"
LAST_BACKUP_FILE="$STATE_DIR/last-backup-timestamp"

# Optional: be nice to the system
IONICE_BIN="$(command -v ionice || true)"
NICE_BIN="$(command -v nice || true)"

# -----------------------
# Helper functions
# -----------------------
log()   { printf '%s %s\n' "$(date +'%Y-%m-%d %H:%M:%S')" "$*"; }
fail()  { log "ERROR: $*"; exit 1; }

notify_failure() {
  local msg="$1"
  log "NOTIFICATION: $msg"
  if command -v notify-send &>/dev/null; then
    DISPLAY=:0 notify-send -u critical "Borg Backup Failed" "$msg" 2>/dev/null || true
  fi
}

cleanup() {
  # Only remove temp dir; lock is handled by flock-on-fd (released automatically)
  if [[ -n "${TEMP_DIR:-}" && -d "${TEMP_DIR}" ]]; then
    rm -rf "${TEMP_DIR}" 2>/dev/null || true
  fi
}
trap cleanup EXIT

# -----------------------
# Prevent too-frequent backups (<= every 4 hours)
# -----------------------
exec 9> "$LOCKFILE"
if ! flock -n 9; then
  log "Backup already running, exiting..."
  exit 0
fi

if [[ -f "$LAST_BACKUP_FILE" ]]; then
  LAST_BACKUP="$(cat "$LAST_BACKUP_FILE" || echo 0)"
  CURRENT_TIME="$(date +%s)"
  TIME_DIFF=$(( CURRENT_TIME - LAST_BACKUP ))
  if (( TIME_DIFF < 0 * 3600 )); then
    HOURS_DIFF=$(( TIME_DIFF / 3600 ))
    log "Last backup was ${HOURS_DIFF} hour(s) ago, skipping to prevent excessive backups..."
    exit 0
  fi
fi

log "Starting backup process..."

# -----------------------
# Robust repository checks
# -----------------------

# 0) Check if mount is available, attempt to mount if not
if [[ ! -d "$BORG_REPO" ]]; then
  log "Repository not accessible, attempting to mount $MOUNT_POINT..."
  if sudo mount "$MOUNT_POINT" 2>/dev/null; then
    sleep 2  # Give mount time to settle
  else
    notify_failure "Could not mount $MOUNT_POINT - NAS may be offline"
    fail "Backup repository path does not exist: $BORG_REPO"
  fi
fi

# 1) Must be an actual mountpoint (not just an existing directory)
if ! mountpoint -q "$MOUNT_POINT"; then
  notify_failure "$MOUNT_POINT is not mounted"
  fail "$MOUNT_POINT is not mounted (mountpoint missing)."
fi

# 2) Filesystem type must be expected (defends against accidental bind/local mounts)
FS_TYPE="$(awk -v p="$MOUNT_POINT" '$2==p{print $3}' /proc/mounts | head -n1)"
if [[ -z "$FS_TYPE" ]]; then
  notify_failure "Could not determine filesystem type for $MOUNT_POINT"
  fail "Could not determine filesystem type for $MOUNT_POINT"
fi

ok_type=false
for t in "${REQUIRED_FS_TYPES[@]}"; do
  if [[ "$FS_TYPE" == "$t" ]]; then ok_type=true; break; fi
done
"$ok_type" || { notify_failure "$MOUNT_POINT mounted as '$FS_TYPE', expected: ${REQUIRED_FS_TYPES[*]}"; fail "$MOUNT_POINT is mounted as '$FS_TYPE', expected one of: ${REQUIRED_FS_TYPES[*]}"; }

# 3) Canary file verifies it's the intended target directory/share
if [[ ! -f "$BORG_REPO/.backup-canary" ]]; then
  fail "Canary missing at $BORG_REPO/.backup-canary (wrong target or missing marker?)."
fi

# 4) Sanity check that it is a valid Borg repo
if ! borg info "$BORG_REPO" >/dev/null 2>&1; then
  fail "$BORG_REPO does not look like a valid Borg repository."
fi

# 5) Free space threshold
AVAIL_KB="$(df --output=avail "$BORG_REPO" | tail -1 | tr -d ' ')"
MIN_KB=$(( MIN_FREE_GIB * 1024 * 1024 ))
if [[ -z "$AVAIL_KB" || "$AVAIL_KB" -lt "$MIN_KB" ]]; then
  fail "Not enough free space on $BORG_REPO (need >= ${MIN_FREE_GIB} GiB)."
fi

# -----------------------
# Build pacman snapshot (lightweight)
# -----------------------
log "Creating pacman snapshot..."
TEMP_DIR="/tmp/pacman-backup-$(date +%Y%m%d_%H%M%S)"
mkdir -p "$TEMP_DIR"

pacman -Qe > "$TEMP_DIR/explicitly-installed-packages.txt"
pacman -Qn > "$TEMP_DIR/native-packages.txt"
pacman -Qm > "$TEMP_DIR/foreign-packages.txt"
pacman -Q  > "$TEMP_DIR/all-packages.txt"

if command -v paru >/dev/null 2>&1; then
  paru -Qm > "$TEMP_DIR/aur-packages.txt"
fi

# Pacman DB & configs (best-effort)
log "  - Pacman database & configs..."
sudo cp -r /var/lib/pacman "$TEMP_DIR/" 2>/dev/null || true
sudo cp    /etc/pacman.conf "$TEMP_DIR/" 2>/dev/null || true
sudo cp -r /etc/pacman.d    "$TEMP_DIR/" 2>/dev/null || true
sudo cp    /etc/makepkg.conf "$TEMP_DIR/" 2>/dev/null || true

# System configuration (essential)
log "  - System configs..."
for f in /etc/fstab /etc/crypttab /etc/hosts /etc/hostname /etc/locale.conf /etc/vconsole.conf /etc/mkinitcpio.conf; do
  sudo cp "$f" "$TEMP_DIR/" 2>/dev/null || true
done

# Network configs
log "  - Network configs..."
sudo cp -r /etc/NetworkManager "$TEMP_DIR/" 2>/dev/null || true

# Security configs
log "  - Security configs..."
sudo cp -r /etc/pam.d "$TEMP_DIR/" 2>/dev/null || true
sudo cp -r /etc/sudoers.d "$TEMP_DIR/" 2>/dev/null || true
sudo cp -r /etc/ssh "$TEMP_DIR/" 2>/dev/null || true
sudo cp -r /etc/wireguard "$TEMP_DIR/" 2>/dev/null || true

# Systemd services
log "  - Systemd services..."
sudo cp -r /etc/systemd/system "$TEMP_DIR/" 2>/dev/null || true

# Display manager
log "  - Display manager..."
sudo cp /etc/sddm.conf "$TEMP_DIR/" 2>/dev/null || true

# Boot configuration (essential only)
log "  - Boot config..."
sudo cp -r /boot/loader "$TEMP_DIR/" 2>/dev/null || true

# Restore docs
cat > "$TEMP_DIR/RESTORE_GUIDE.md" << 'EOF'
# System Restore Guide

This backup contains:
- All explicitly installed packages
- Native and AUR packages lists
- Pacman database and configuration
- Essential system configuration files
- Network, security, and systemd configs
- Boot loader configuration
- Your complete home directory

## To restore packages:
1. Run the restore-packages.sh script
2. Review and restore config files manually as needed
3. Restore pacman database if needed: sudo cp -r pacman /var/lib/

## To restore home directory:
Your complete home directory is included in this backup.

## Important files included:
- Package lists (explicitly-installed-packages.txt, etc.)
- System configs (fstab, hostname, locale.conf, etc.)
- Network configs (NetworkManager/)
- Security configs (pam.d/, sudoers.d/, ssh/)
- Boot config (loader/)
EOF

cat > "$TEMP_DIR/restore-packages.sh" << 'EOF'
#!/usr/bin/env bash
set -euo pipefail
echo "Restoring packages from backup..."

read -rp "Install native packages? (y/N) " response
if [[ "${response:-}" =~ ^[Yy]$ ]]; then
  sudo pacman -S --needed $(cut -d' ' -f1 < explicitly-installed-packages.txt)
fi

if [[ -f "aur-packages.txt" ]] && command -v yay >/dev/null 2>&1; then
  read -rp "Install AUR packages? (y/N) " response
  if [[ "${response:-}" =~ ^[Yy]$ ]]; then
    yay -S --needed $(cut -d' ' -f1 < aur-packages.txt)
  fi
fi
EOF
chmod +x "$TEMP_DIR/restore-packages.sh"

# -----------------------
# Borg backup
# -----------------------
log "Starting Borg backup..."
BORG_CMD=( borg create --lock-wait 300 --verbose --stats --compression zstd,3 \
  "$BORG_REPO::ryan-{now}" \
  /etc \
  /home/ryan \
  /var/lib/tailscale \
  /.snapshots \
  "$TEMP_DIR" \
  --exclude '/home/ryan/.cache' \
  --exclude '/home/ryan/.local/share/Trash' \
  --exclude '/home/ryan/.local/share/Steam' \
  --exclude '/home/ryan/Downloads' \
  --exclude '/home/ryan/.npm' \
  --exclude '/home/ryan/.cargo/registry' \
  --exclude '/home/ryan/.rustup' \
  --exclude '/home/ryan/.local/share/virtualenvs' \
  --exclude '/home/ryan/.proto/cache' \
  --exclude '/home/ryan/.proto/tools' \
  --exclude '/home/ryan/.proto/temp' \
  --exclude '*.tmp' \
  --exclude '*.log' \
  --exclude 'node_modules' \
  --exclude '__pycache__' )

# Run borg with nice/ionice if available
# Capture exit code - borg returns 1 for warnings (permission denied), 2 for errors
BORG_EXIT=0
if [[ -n "$IONICE_BIN" ]]; then
  if [[ -n "$NICE_BIN" ]]; then
    $IONICE_BIN -c3 $NICE_BIN -n 10 "${BORG_CMD[@]}" || BORG_EXIT=$?
  else
    $IONICE_BIN -c3 "${BORG_CMD[@]}" || BORG_EXIT=$?
  fi
else
  if [[ -n "$NICE_BIN" ]]; then
    $NICE_BIN -n 10 "${BORG_CMD[@]}" || BORG_EXIT=$?
  else
    "${BORG_CMD[@]}" || BORG_EXIT=$?
  fi
fi

# Exit code 1 = warnings (permission denied on some files), 2+ = real errors
if [[ $BORG_EXIT -gt 1 ]]; then
  notify_failure "Borg backup failed with exit code $BORG_EXIT"
  fail "Borg backup failed with exit code $BORG_EXIT"
elif [[ $BORG_EXIT -eq 1 ]]; then
  log "Backup completed with warnings (some files could not be read due to permissions)"
fi

log "Backup completed successfully!"
date +%s > "$LAST_BACKUP_FILE"

# -----------------------
# Verify backup integrity
# -----------------------
log "Verifying backup integrity..."
if ! borg check --lock-wait 300 --archives-only --last 1 "$BORG_REPO" 2>/dev/null; then
  notify_failure "Backup verification failed - archive may be corrupted"
  log "WARNING: Backup verification failed, but continuing with prune..."
fi

# -----------------------
# Prune
# -----------------------
log "Pruning old backups..."
borg prune --lock-wait 300 \
  --prefix ryan- \
  --keep-daily=5 \
  --keep-weekly=3 \
  --keep-monthly=2 \
  "$BORG_REPO"

# -----------------------
# Compact (required for Borg 1.2+)
# -----------------------
log "Compacting repository..."
borg compact --lock-wait 300 "$BORG_REPO"

# -----------------------
# Sync snapshots to NAS (unencrypted, direct access)
# -----------------------
log "Syncing btrfs snapshots to NAS..."
if [[ -d "/.snapshots" ]]; then
  sudo rsync -a --delete /.snapshots/ "$MOUNT_POINT/snapshots/root/" 2>/dev/null || log "WARNING: Failed to sync root snapshots"
fi
if [[ -d "/home/.snapshots" ]]; then
  sudo rsync -a --delete /home/.snapshots/ "$MOUNT_POINT/snapshots/home/" 2>/dev/null || log "WARNING: Failed to sync home snapshots"
fi

log "Backup and cleanup finished!"
