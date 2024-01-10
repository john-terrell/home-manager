{ pkgs, ... }: {
  home.username = "johnt";
  home.homeDirectory = if pkgs.hostPlatform.isLinux then "/home/johnt" else "/Users/johnt";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.bashInteractive
    pkgs.neofetch         # 
    pkgs.pinentry
    pkgs.sequoia-sq       # gpg replacement (provides sq command)
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
    signing.signByDefault = true;
    delta.enable = true;
  };

  programs.gpg = {
    enable = true;
    publicKeys = [
      {
        text = builtins.readFile ./public_keys/john_terrell.asc;
        trust = "ultimate";
      }
      {
        text = builtins.readFile ./public_keys/bill_coldwell.asc;
        trust = "full";
      }
      {
        text = builtins.readFile ./public_keys/chris_hanson.asc;
        trust = "full";
      }
    ];
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
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  programs.zsh = {
    enable = true;
    profileExtra = builtins.readFile ./zprofile;
    initExtra = builtins.readFile ./zshrc;
  };
}
