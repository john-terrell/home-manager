{ pkgs, ... }: {
  home.username = "johnt";
  home.homeDirectory = if pkgs.hostPlatform.isLinux then "/home/johnt" else "/Users/johnt";
  home.stateVersion = "22.11";

  home.sessionVariables = { 
    VCPKG_ROOT = "~/Projects/vcpkg";
  };

  home.sessionPath = [
    "$VCPKG_ROOT"
  ];

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  home.packages = [
    pkgs.ansible
    pkgs.bashInteractive
    pkgs.ffmpeg
    pkgs.fossil
    pkgs.gcr                # for gnome pinentry
    pkgs.graphviz
#    pkgs.gtkwave
    pkgs.jq
    pkgs.kubectl
    pkgs.magic-wormhole-rs  # secure file transfers
    pkgs.mill               # Scala build tool
    pkgs.neofetch           # 
    pkgs.ninja
#    pkgs.npm
#    pkgs.openjdk17
    pkgs.pdfgrep
    pkgs.poetry		          # python poetry
#    pkgs.podman
    pkgs.pre-commit
    pkgs.protobuf
    pkgs.python3
    pkgs.rage               # file encryption
    pkgs.rustup
    pkgs.scala-cli
    pkgs.sequoia-sq         # gpg replacement (provides sq command)
    pkgs.sequoia-sqop
    pkgs.sequoia-chameleon-gnupg
    pkgs.sops    
    pkgs.terraform           # security as a service
  ];

  programs.btop = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.eza = {        # 'ls' replacement
    enable = true;
    git = true;
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
    };
  };

  programs.ripgrep = {
    enable = true;
  };

  programs.sbt = {
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

  services.gpg-agent = {
    enable = true;
    enableExtraSocket = true;
    defaultCacheTtl = 14400;
    maxCacheTtl = 86400;
    enableSshSupport = true;
    enableZshIntegration = true;
#    pinentryPackage = pkgs.pinentry-gtk2;
    pinentryPackage = pkgs.pinentry_mac;
    sshKeys = [
      "C0B077947A793E7D66DCE451EA5B9A8C05A954D6"
    ];
  };
}
