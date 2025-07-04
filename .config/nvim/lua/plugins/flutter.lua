-- ====================================
-- FLUTTER DEVELOPMENT SETUP
-- ====================================

return {
  -- Dart and Flutter language support
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = function()
      require("flutter-tools").setup({
        ui = {
          border = "rounded",
          notification_style = "native",
        },
        decorations = {
          statusline = {
            app_version = false,
            device = true,
            project_config = false,
          },
        },
        debugger = {
          enabled = true,
          exception_breakpoints = {},
          evaluate_to_string_in_debug_views = true,
          register_configurations = function(paths)
            require("dap").adapters.dart = {
              type = "executable",
              command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
              args = { "flutter" },
            }
            require("dap").configurations.dart = {
              {
                type = "dart",
                request = "launch",
                name = "Launch flutter",
                dartSdkPath = paths.dart_sdk,
                flutterSdkPath = paths.flutter_sdk,
                program = "${workspaceFolder}/lib/main.dart",
                cwd = "${workspaceFolder}",
              },
            }
          end,
        },
        flutter_path = "/opt/homebrew/bin/flutter", -- Uses flutter from PATH
        root_patterns = { ".git", "pubspec.yaml" },
        fvm = false, -- Set to true if using Flutter Version Management
        widget_guides = {
          enabled = true,
        },
        closing_tags = {
          highlight = "Comment",
          prefix = "// ",
          enabled = true,
        },
        dev_log = {
          enabled = true,
          notify_errors = false,
          open_cmd = "tabedit",
        },
        dev_tools = {
          autostart = false,
          auto_open_browser = false,
        },
        outline = {
          open_cmd = "30vnew",
          auto_open = false,
        },
        lsp = {
          color = {
            enabled = true,
            background = false,
            background_color = nil,
            foreground = false,
            virtual_text = true,
            virtual_text_str = "■",
          },
          on_attach = function(client, bufnr)
            -- Custom keymaps for Flutter
            local opts = { buffer = bufnr, silent = true }
            vim.keymap.set(
              "n",
              "<leader>Fo",
              "<cmd>FlutterOutlineToggle<CR>",
              vim.tbl_extend("force", opts, { desc = "Flutter: Toggle Outline" })
            )
            vim.keymap.set(
              "n",
              "<leader>Fr",
              "<cmd>FlutterReload<CR>",
              vim.tbl_extend("force", opts, { desc = "Flutter: Hot Reload" })
            )
            vim.keymap.set(
              "n",
              "<leader>FR",
              "<cmd>FlutterRestart<CR>",
              vim.tbl_extend("force", opts, { desc = "Flutter: Hot Restart" })
            )
            vim.keymap.set(
              "n",
              "<leader>Fq",
              "<cmd>FlutterQuit<CR>",
              vim.tbl_extend("force", opts, { desc = "Flutter: Quit" })
            )
            vim.keymap.set(
              "n",
              "<leader>Fd",
              "<cmd>FlutterDetach<CR>",
              vim.tbl_extend("force", opts, { desc = "Flutter: Detach" })
            )
            vim.keymap.set(
              "n",
              "<leader>Ft",
              "<cmd>FlutterDevTools<CR>",
              vim.tbl_extend("force", opts, { desc = "Flutter: Dev Tools" })
            )
            vim.keymap.set(
              "n",
              "<leader>FL",
              "<cmd>FlutterLspRestart<CR>",
              vim.tbl_extend("force", opts, { desc = "Flutter: Restart LSP" })
            )
            vim.keymap.set(
              "n",
              "<leader>Fs",
              "<cmd>FlutterSuper<CR>",
              vim.tbl_extend("force", opts, { desc = "Flutter: Go to Super Class" })
            )
            vim.keymap.set(
              "n",
              "<leader>Fe",
              "<cmd>FlutterEmulators<CR>",
              vim.tbl_extend("force", opts, { desc = "Flutter: Emulators" })
            )
            vim.keymap.set(
              "n",
              "<leader>Fc",
              "<cmd>FlutterCopyProfilerUrl<CR>",
              vim.tbl_extend("force", opts, { desc = "Flutter: Copy Profiler URL" })
            )
          end,
          capabilities = require("blink.cmp").get_lsp_capabilities(),
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            analysisExcludedFolders = {
              vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
              vim.fn.expand("$HOME/.pub-cache"),
              vim.fn.expand("$HOME/tools/flutter"),
            },
          },
        },
      })
    end,
  },

  -- Better Dart syntax highlighting
  {
    "dart-lang/dart-vim-plugin",
    ft = "dart",
    config = function()
      vim.g.dart_style_guide = 2
      vim.g.dart_format_on_save = 1
    end,
  },

  -- Pubspec.yaml support
  {
    "akinsho/pubspec-assist.nvim",
    ft = "yaml",
    event = "BufEnter pubspec.yaml",
    config = function()
      require("pubspec-assist").setup()
    end,
  },

  -- Additional Treesitter parsers for Flutter/Dart
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "dart",
        "yaml",
        "json",
      })
    end,
  },

  -- Mason configuration for Flutter tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "dart-debug-adapter",
        "json-lsp",
      })
    end,
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        dartls = {
          -- Dart LSP server configuration
          -- flutter-tools.nvim handles this, but keeping for reference
        },
      },
    },
  },

  -- Debugger support
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "dart-debug-adapter" })
        end,
      },
    },
  },

  -- File type detection improvements
  {
    "nathom/filetype.nvim",
    opts = {
      overrides = {
        extensions = {
          dart = "dart",
          arb = "json", -- Flutter localization files
        },
        literal = {
          ["pubspec.yaml"] = "yaml",
          ["pubspec.yml"] = "yaml",
          ["analysis_options.yaml"] = "yaml",
        },
      },
    },
  },

  -- Which-key integration for Flutter commands
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>F", group = "Flutter", icon = " " },
      },
    },
  },
}
