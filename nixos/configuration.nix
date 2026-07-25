# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> {
    config = config.nixpkgs.config;
  };
in
{

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  #nmcli config for uni wifi
  #ipv4.method auto
  #802-1x.eap peap
  #802-1x.phase2-auth mschapv2
  #802-1x.identity username
  #802-1x.password password
  #802-1x.wifi-sec.key-mgmt wpa-eap
  networking.networkmanager.enable = true;

  #audio
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   pulse.enable = true;
  # };




  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # Set your time zone.
  time.timeZone = "America/Winnipeg";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
  };

  # Configure console keymap
  console.keyMap = "dvorak";

  #To get electron to respect custom keymap. 
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.

  users.users.logan = {
    isNormalUser = true;
    description = "Logan Decock";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
    environment.systemPackages = with pkgs; [
    #terminal applications 

        ffmpeg
        wev

        #development
        unstable.awscli2
        tenv

        pkgs.man-pages
        pkgs.man-pages-posix
        github-cli
        git
        gitlab-runner

        sqlite
        mysql80

        go

        bun
        nodejs_23

        python3
        python312Packages.pip
        python312Packages.flask
        python312Packages.flake8
        python313Packages.pyserial
        pyright

        clang
        clang-tools
        gcc
        gnumake
        valgrind
        gdb
        xxd
        lldb

        gradle_7
        android-tools
        google-java-format
        openjdk23
        jdt-language-server


        ruby
        gemstash
        jekyll

        dos2unix

        postman
        netcat
        socat

        #terminal necisseties
        tmux
        openssh
        zip
        unzip
        ripgrep
        fd

    texliveFull
    ventoy-full
 

    #graphical applications
    firefox
    thunderbird
    telegram-desktop
    discord
    gimp
    swayimg #everything but pdf viewer
    zathura #pdf viewer
    obsidian
    vscode
    libreoffice-qt6-fresh
    anki
    zoom-us
    arduino-ide
    pavucontrol

    #desktop environment specific packages
    wl-clipboard
    cliphist
    fuzzel
    alsa-utils
    brightnessctl
    wl-clipboard #nvim uses to interface with clipboard
    slurp
    grim
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    swt
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];
  
  
    # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  #nvim config
  #Use the Nix package search engine to find
  #even more plugins : https://search.nixos.org/packages
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    configure = {
      customRC = ''

        set showmatch               " show matching 
        set ignorecase              " case insensitive 
        set mouse=v                 " middle-click paste with 
        set hlsearch                " highlight search
        set incsearch               " incremental search
        set tabstop=4               " number of columns occupied by a tab 
        set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
        set expandtab               " converts tabs to white space
        set shiftwidth=4               " width for autoindents
        set autoindent              " indent a new line the same amount as the line just typed
        set nu rnu                  " add hybrid line numbers
        set wildmode=longest,list   " get bash‑like tab completions
        set mouse=a                 " enable mouse click
        set ttyfast                 " Speed up scrolling in Vim
        set formatoptions-=c formatoptions-=r formatoptions-=o     " disable auto insertion of comments
        set number
        set relativenumber
        
        colorscheme jellybeans "colorscheme
        "colorscheme molokayo    "colorscheme
        highlight Comment cterm = italic ctermfg=Gray   "changes comment colour
        highlight Conceal ctermfg = darkGray    "sets conceal group (tab indicatior) color to gray
        let g:indentLine = '▏'  "sets the tab display character

        let mapleader = ' '
        map ; :
        map <leader>p "0p
        map <leader>P "0P
        map <leader>bp :bp<CR>
        map <leader>bn :bn<CR>
 
        let g:vimtex_view_general_viewer = 'zathura'
        " set spell                 " enable spell check (may need to download language package)
        " copen opens the quick fix list, which is very useful after the :make command. The quick fix list will parse all the errors, and cn, cp, cfirst and clast will take you to the 
        " next, prev, first, and last error.

        "argdo, cdo, bdo run commands in all args, quick fix list panes and buffers
        " NORM runs motions, so NORM ggdG  would delete the whole file and 
        " bdo NORM ggdG would delete the contents of every file open in a buffer.

        lua << EOF
           require("conform").setup({
            formatters_by_ft = {
                java = { "google-java-format" }
            },
           })
        EOF

        lua << EOF
          require("lspconfig").clangd.setup({})
        EOF

        lua << EOF
            vim.keymap.set("n", "<space>f", function() 
                require("conform").format({ async = true })
                vim.notify("formatted")
            end)


          -- enable tree sitt highlighting
          require'nvim-treesitter.configs'.setup {
             highlight = {
                 enable = true,
             },
          }

        EOF

        lua << EOF
          -- error highlighting
          require("lspconfig").pyright.setup({})

          vim.diagnostic.config({
            virtual_text = true,
            underline = true,
            signs = true,
            update_in_insert = false,
          })

        EOF

        lua << EOF
          local null_ls = require("null-ls")

          null_ls.setup({
            sources = {
              null_ls.builtins.diagnostics.eslint,
              null_ls.builtins.diagnostics.flake8,
            },
          })
        EOF

        lua << EOF
          require("lspconfig").jdtls.setup({
            cmd = { "jdtls" },
            root_dir = require("lspconfig.util").root_pattern(
              "pom.xml",
              "build.gradle",
              ".git"
            ),
          })
        EOF

        lua << EOF
          require("oil").setup{
            view_options = {
              show_hidden = true
            }
          }
          vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = 'Open parent directory' })
        EOF

        lua << EOF
          require("coverage").setup({
            commands = true, -- create commands
            highlights = {
                    -- customize highlight groups created by the plugin
                    covered = { fg = "#C3E88D" },   -- supports style, fg, bg, sp (see :h highlight-gui)
                    uncovered = { fg = "#F07178" },
            },
            signs = {
                    -- use your own highlight groups or text markers
                    covered = { hl = "CoverageCovered", text = "▎" },
                    uncovered = { hl = "CoverageUncovered", text = "▎" },
            },
            summary = {
                    -- customize the summary pop-up
                    min_coverage = 80.0,      -- minimum coverage threshold (used for highlighting)
            },
            lang = {
                    -- customize language specific settings
            },
        })

        EOF

        lua << EOF
          local builtin = require('telescope.builtin')
          local find_files = function() 
            builtin.find_files{ hidden = true }
          end
          vim.keymap.set('n', "<leader>ts", find_files, { desc = 'Telescope find files' })
          vim.keymap.set('n', '<leader>tt', builtin.live_grep, { desc = 'Telescope live grep' })
          vim.keymap.set('n', '<leader>tb', builtin.buffers, { desc = 'Telescope buffers' })
        EOF

        lua << EOF
          local codesnap = require("codesnap")
          codesnap.setup{
            show_line_number = true,
            snapshot_config = { 
              background = "#0C3321",
              watermark = {
                content = ""
              }
            }
          }

          vim.keymap.set('v', '<leader>cs', '<cmd>CodeSnap<cr>', { desc = 'Copy a snapshot of the selected text to clipboard'} )

        EOF

      '';
      packages.packages = with pkgs.vimPlugins; {
        #loaded on launch
        start = [ 
          vim-surround
          vim-sleuth #matches vim settings to open file e.g. no mixing tabs
          awesome-vim-colorschemes
          codesnap-nvim
          oil-nvim
          vim-commentary
          coq_nvim
          vimtex 
          undotree
          telescope-nvim
          markdown-preview-nvim
          conform-nvim
          nvim-treesitter.withAllGrammars
          nvim-lspconfig
          null-ls-nvim
          vim-matchup #better % matching
          nvim-coverage
          # nvim‑tresitter-context
        ];
      };
    };
  };

  programs.foot = {
    enable = true;
    # needed?
    # enableBashIntegration = true

    settings = {

      main = {
        font="monospace:size=18";
      };

      colors = {
        background="000000";
        alpha=0.985;
      };

    };

  };

  #sway window manager config
  programs.sway = {
  	enable = true;
	wrapperFeatures.gtk = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.startAgent = true;
}
