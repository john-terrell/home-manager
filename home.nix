{ pkgs, ... }: {
  home.username = "johnt";
  home.homeDirectory = if pkgs.hostPlatform.isLinux then "/home/johnt" else "/Users/johnt";
  home.stateVersion = "25.05";

  home.sessionVariables = { 
    QT6_DIR = "~/Qt/6.8.3/macos/lib/cmake/Qt6";
    TRACER_HMI_INSTALL_PATH = "~/Projects/CRL/install/";
    DOCKER_HOST = "10.10.4.12";
  };

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  home.file.".p10k.zsh".text = builtins.readFile ./p10k.zsh;

  home.packages = [
    pkgs._7zz
    pkgs.backrest
    pkgs.bashInteractive
    pkgs.docker
    pkgs.gcr                # for gnome pinentry
    pkgs.git-filter-repo
    pkgs.git-lfs
    pkgs.graphviz
    # pkgs.helm
    pkgs.kubectl
    pkgs.magic-wormhole-rs  # secure file transfers
    pkgs.meslo-lgs-nf
    pkgs.neofetch           # 
    pkgs.ninja
    pkgs.nixfmt
    pkgs.pass
    pkgs.pdfgrep
    pkgs.pinentry-gtk2
    pkgs.pkg-config
#    pkgs.rage               # file encryption
#    pkgs.sequoia-sq         # gpg replacement (provides sq command)
#    pkgs.sequoia-sqop
#    pkgs.sequoia-chameleon-gnupg
    pkgs.restic
    pkgs.sops    
    pkgs.tree
    pkgs.wget
    pkgs.zsh-powerlevel10k
    pkgs.zstd
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

    initContent = ''
      # p10k instant prompt
      P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
      [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"

      source ~/.p10k.zsh

      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    '';

    plugins = with pkgs; [
      {
        file = "powerlevel10k.zsh-theme";
        name = "powerlevel10k";
        src = "${zsh-powerlevel10k}/share/zsh-powerlevel10k";
      }
    ];
  };

  services.gpg-agent = {
    enable = true;
    enableExtraSocket = true;
    defaultCacheTtl = 14400;
    maxCacheTtl = 86400;
    enableSshSupport = true;
    enableZshIntegration = true;
    pinentry.package = if pkgs.hostPlatform.isLinux then pkgs.pinentry-gtk2 else pkgs.pinentry_mac;
    sshKeys = [
      "C0B077947A793E7D66DCE451EA5B9A8C05A954D6"
    ];
  };
}
