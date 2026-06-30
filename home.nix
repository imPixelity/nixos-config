{ config, pkgs, ... }:
{
  home.username = "photon";
  home.homeDirectory = "/home/photon";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    wget
    btop
    curl
    tree
    unzip
    fastfetch
  ];

  programs.firefox.enable = true;
  programs.alacritty.enable = true;
  programs.fuzzel.enable = true;
  programs.vim = {
    enable = true;
    settings = {
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
    };
    extraConfig = ''
      set clipboard=unnamedplus
    '';
  };
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    prefix = "C-a";
    mouse = true;
    keyMode = "vi";
    extraConfig = ''
      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      unbind -T copy-mode-vi MouseDragEnd1Pane
    '';
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 10000;
      save = 10000;
      ignoreAllDups = true;
      path = "$HOME/.zsh_history";
      share = true;
    };
    initContent = ''
      eval "$(starship init zsh)"
    '';
  };
  programs.starship = {
    enable = true;
  };
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "phyxl";
        email = "dzikrynp14@gmail.com";
      };
      init.defaultBranch = "main";
      core.editor = "vim";
    };
  };
  programs.qutebrowser.enable = true;
}
