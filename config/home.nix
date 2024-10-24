{ inputs, config, pkgs, ... }: {
  imports = [
    ./extra-progs.nix
    ./firefox
    ./zsh
    ./wine
    #./theme
    ./tmux
    ./alacritty
    ./scripts
  ];
  home = {
    username = "deck";
    homeDirectory = "/home/deck";
    stateVersion = "24.05";
    packages = with pkgs; [
      gay
      lolcat
      hyfetch
      spotify
      vesktop
      prismlauncher
      retroarch
      retroarch-assets
      retroarch-joypad-autoconfig
      easyrpg-player
      itch
      
      vulkan-tools
      vrrtest

      google-chrome
      
      nh
      nix-output-monitor
      nvd
    ];
  };
  nix = {
    package = pkgs.nix;
    #settings.experimental-feautres = [ "nix-command" "flakes" ];
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
    FLAKE = "/home/deck/pawprint";
  };
}
