{ pkgs, ... }: {
  home.packages = with pkgs; [
    wineWowPackages.stable
    #wine
    #(wine.override { wineBuild = "wine64"; })
    #wine64
    #wineWowPackages.staging 
    #wineWowPackages.stagingFull
    winetricks
    protontricks
    
    #bottles
    #xclip 
    #working clipboard
    #wl-paste -t text -w xclip -selection clipboard
  ];
}
