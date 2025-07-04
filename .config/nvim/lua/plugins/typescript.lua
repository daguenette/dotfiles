-- ====================================
-- TYPESCRIPT & REACT NATIVE SETUP
-- ====================================

return {
  -- TypeScript language server and tools
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- TypeScript/JavaScript LSP
        ts_ls = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        -- ESLint for linting
        eslint = {
          settings = {
            workingDirectories = { mode = "auto" },
          },
        },
      },
    },
  },

  -- Mason configuration for TypeScript tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "typescript-language-server",
        "eslint-lsp",
        "prettier",
        "js-debug-adapter",
      })
    end,
  },

  -- Treesitter for TypeScript/JavaScript
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "typescript",
        "javascript",
        "tsx",
        "json",
        "yaml",
      })
    end,
  },

  -- TypeScript debugging with DAP
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "js-debug-adapter" })
        end,
      },
    },
    config = function()
      -- DAP configuration will be set up when js-debug-adapter is installed
      vim.defer_fn(function()
        local dap = require("dap")
        
        -- Node.js debugging setup
        dap.adapters.node2 = {
          type = "executable",
          command = "node",
          args = { vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug-adapter" },
        }

        -- Basic configurations for TypeScript/JavaScript
        local config = {
          {
            type = "node2",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            protocol = "inspector",
            console = "integratedTerminal",
          },
        }

        dap.configurations.typescript = config
        dap.configurations.javascript = config
        dap.configurations.javascriptreact = config
        dap.configurations.typescriptreact = config
      end, 1000)
    end,
  },

  -- React Native specific tools
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-jest",
    },
    opts = {
      adapters = {
        "neotest-jest",
      },
    },
  },

  -- Auto-format on save
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
      },
    },
  },

  -- Which-key integration
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>t", group = "TypeScript", icon = "󰛦" },
      },
    },
  },
}