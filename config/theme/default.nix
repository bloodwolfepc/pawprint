{ pkgs, inputs, lib, config, ... }: {
  imports = [ inputs.stylix.homeManagerModules.stylix ];
  stylix = {
    image = ../assets/wallpapers/flcl.png;
    enable = true;
    base16Scheme = "${ pkgs.base16-schemes }/share/themes/windows-95.yaml";
    fonts = {
      monospace = {
        package = pkgs.unscii;
        name = "Unscii";
      };
      sansSerif = {
        package = pkgs.unscii;
        name = "Unscii";
      };
      serif = {
        package = pkgs.unscii;
        name = "Unscii";
      }; 
      emoji = {
        package = pkgs.noto-fonts-monochrome-emoji;
        name = "Noto Monochrome Emoji";
      };
    };
    polarity = "dark";   
  };
}
