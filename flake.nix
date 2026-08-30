{
  description = "ryan's dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      # Pinned to the 26.07 release tag
      url = "github:NotAShelf/nvf/v26.07";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fzf-git-sh = {
      url = "github:junegunn/fzf-git.sh";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nvf,
    fzf-git-sh,
    ...
  }: {
    homeConfigurations.ryan = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = {inherit fzf-git-sh;};
      modules = [
        nvf.homeManagerModules.nvf
        ./home/ryan.nix
      ];
    };
  };
}
