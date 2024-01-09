{ pkgs, ... }: {
  home.username = "johnt";
  home.homeDirectory = "/Users/johnt";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.bashInteractive
    pkgs.neofetch         # 
    pkgs.pinentry
  ];

  programs.chromium = {
    enable = pkgs.hostPlatform.isLinux;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.eza = {        # 'ls' replacement
    enable = true;
    enableAliases = true;
    git = true;
  };

  programs.firefox = {
    enable = pkgs.hostPlatform.isLinux;
  };

  programs.fzf = {        # fuzzy search tool
    enable = true;
  };

  programs.git = {
    enable = true;
    includes = [{ path = "~/.config/home-manager/gitconfig"; }];
    userEmail = "john@coolpeople.io";
    userName = "John W. Terrell";
    signing.key = "64EDA67B2782882D8A5A83EC2E424258DD3731F4";
    signing.signByDefault = false;
    delta.enable = true;
  };

  programs.gpg = {
    enable = true;
  };

  programs.htop = {
    enable = true;
  };

  programs.k9s = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.rbw = {      # Bitwarden CLI client
    enable = true;
    settings = {
      email = "john.terrell@gmail.com";
      pinentry = "curses";
    };
  };

  programs.ripgrep = {
    enable = true;
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
  };

  programs.zoxide = {     # 'cd' replacement (provides 'z' alias)
    enable = true;
  };

  programs.zsh = {
    enable = true;
    profileExtra = builtins.readFile ./zprofile;
    initExtra = builtins.readFile ./zshrc;
  };

  services = {
    gpg-agent = {
      enable = pkgs.hostPlatform.isLinux;
      enableSshSupport = true;
    };
  };
}
