{ inputs, config, pkgs, ... }: {
  imports = [
    ./extra-progs.nix
    ./firefox
    ./zsh
    ./wine
    ./theme
    ./tmux
    ./scripts
  ];
  home = {
    username = "deck";
    homeDirectory = "/home/deck";
    stateVersion = "24.05";
    packages = with pkgs; [
      inputs.nixvim.packages.x86_64-linux.default
      gay
      hyfetch
      spotify
      discord
      
      #reaper
      #gimp
      #obs
      
      prismlauncher
      retroarch
      retroarch-assets
      retroarch-joypad-autoconfig
      easyrpg-player
      itch
      
      vulkan-tools
      vrrtest

      google-chrome
    ];
  };
  nix = {
    package = pkgs.nix;
    settings.experimental-feautres = [ "nix-command" "flakes" ];
  };
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
  programs.home-manager.enable = true;
  home.sessionVariables = {
    editor = "nvim";
  };
}
