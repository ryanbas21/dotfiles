{
  pkgs,
  fzf-git-sh,
  ...
}: {
  home.username = "ryan";
  home.homeDirectory = "/home/ryan";
  home.stateVersion = "25.05";

  imports = [
    ./fish.nix
  ];

  # Preserve the one package currently living in `nix profile` — home-manager
  # activation repoints ~/.nix-profile, so elm-format must survive here.
  home.packages = [pkgs.elmPackages.elm-format];

  programs.nvf = {
    enable = true;
    defaultEditor = true;
    settings = {
      imports = [../nvf];
    };
  };
}
