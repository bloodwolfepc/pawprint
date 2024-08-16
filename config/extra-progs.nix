{ inputs, ... }: {
  programs = {
    gh.enable = true;
    htop.enable = true;
    btop.enable = true;
    lf.enable = true;
    ripgrep.enable = true;
    ssh.enable = true;
  };
  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "transgender";
      mode = "rgb";
      color_align = {
        mode = "horizontal";
      };
    };
  };
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    options = [
      "--cmd cd"
    ];
  };
  home.packages = [ inputs.nixvim.packages.x86_64-linux.default ];
}
