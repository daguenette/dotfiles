-- ====================================
-- GODOT C# DEVELOPMENT SETUP
-- ====================================
return {
  -- C# development with automatic LSP handling
  {
    "iabdelkareem/csharp.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
      "Tastyep/structlog.nvim",
    },
    ft = "cs",
    init = function()
      -- Set environment variables before plugin loads
      vim.env.DOTNET_ROOT = "/usr/local/share/dotnet"
      vim.env.DOTNET_HOST_PATH = "/usr/local/share/dotnet/dotnet"
      vim.env.DOTNET_MSBUILD_SDK_RESOLVER_CLI_DIR = "/usr/local/share/dotnet"
      vim.env.PATH = "/usr/local/share/dotnet:" .. (vim.env.PATH or "")
    end,
    config = function()
      require("csharp").setup({
        lsp = {
          enable_editor_config_support = true,
          enable_ms_build_load_projects_on_demand = false,
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
          sdk_include_prereleases = true,
          analyze_open_documents_only = false,
        },
        logging = {
          level = "INFO",
        },
        dap = {
          adapter_name = "coreclr",
        },
      })
    end,
  },
  -- Godot integration (keep existing)
  {
    "habamax/vim-godot",
    ft = { "gdscript", "gdshader" },
    config = function()
      vim.g.godot_executable = "/opt/homebrew/bin/godot-mono"

      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { "*.gd", "*.cs" },
        callback = function()
          local godot_project = vim.fn.findfile("project.godot", ".;")
          if godot_project ~= "" then
            vim.b.godot_project = true
            local opts = { buffer = true, silent = true }
            vim.keymap.set(
              "n",
              "<leader>Gr",
              ":GodotRun<CR>",
              vim.tbl_extend("force", opts, { desc = "Godot: Run Project" })
            )
            vim.keymap.set(
              "n",
              "<leader>Gs",
              ":GodotRunScene<CR>",
              vim.tbl_extend("force", opts, { desc = "Godot: Run Current Scene" })
            )
            vim.keymap.set(
              "n",
              "<leader>Go",
              ":!open -a '/opt/homebrew/bin/godot-mono' .<CR>",
              vim.tbl_extend("force", opts, { desc = "Godot: Open in Editor" })
            )
          end
        end,
      })
    end,
  },

  -- Mason configuration (remove OmniSharp)
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "netcoredbg", -- .NET debugger
        "json-lsp", -- JSON support
        -- No OmniSharp here - csharp.nvim handles it
      })
    end,
  },

  -- Treesitter for C# and GDScript
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "c_sharp",
        "gdscript",
        "godot_resource",
        "json",
        "xml",
        "yaml",
      })
    end,
  },

  -- Which-key integration
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>G", group = "Godot", icon = "🎮" },
        { "<leader>C", group = "C#", icon = "" },
      },
    },
  },
}
