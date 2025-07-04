-- ====================================
-- SUPER MAVEN AI CODE COMPLETION
-- ====================================

return {
  -- Super Maven AI code completion
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<Tab>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
        ignore_filetypes = {
          cpp = true, -- Add any filetypes you want to disable
        },
        color = {
          suggestion_color = "#565f89",
          cterm = 244,
        },
        log_level = "info", -- set to "off" to disable logging completely
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = false, -- disables built in keymaps for more manual control
        condition = function()
          return true -- Enable Super Maven by default
        end,
      })
    end,
  },

  -- Which-key integration for Super Maven commands
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>ai", group = "AI Assistant", icon = "🤖" },
        {
          "<leader>ait",
          function()
            require("supermaven-nvim.api").toggle()
          end,
          desc = "Toggle Super Maven",
          icon = "🔄",
        },
        {
          "<leader>ais",
          function()
            require("supermaven-nvim.api").status()
          end,
          desc = "Super Maven Status",
          icon = "ℹ️",
        },
        {
          "<leader>air",
          function()
            require("supermaven-nvim.api").restart()
          end,
          desc = "Restart Super Maven",
          icon = "🔄",
        },
        {
          "<leader>ail",
          function()
            require("supermaven-nvim.api").use_free_version()
          end,
          desc = "Use Free Version",
          icon = "🆓",
        },
        {
          "<leader>aip",
          function()
            require("supermaven-nvim.api").use_pro_version()
          end,
          desc = "Use Pro Version",
          icon = "💎",
        },
      },
    },
  },

  -- Status line integration (optional)
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      local function supermaven_status()
        local api = require("supermaven-nvim.api")
        if api.is_running() then
          return "🤖 SM"
        else
          return ""
        end
      end

      -- Add Super Maven status to lualine
      table.insert(opts.sections.lualine_x, 1, {
        supermaven_status,
        color = { fg = "#00ff00" },
      })
    end,
  },

  -- Custom keymaps for Super Maven
  {
    "folke/which-key.nvim",
    keys = {
      {
        "<C-l>",
        function()
          require("supermaven-nvim.completion_preview").on_accept_suggestion()
        end,
        mode = "i",
        desc = "Accept Super Maven suggestion",
      },
      {
        "<C-h>",
        function()
          require("supermaven-nvim.completion_preview").on_clear_suggestion()
        end,
        mode = "i",
        desc = "Clear Super Maven suggestion",
      },
      {
        "<C-k>",
        function()
          require("supermaven-nvim.completion_preview").on_accept_suggestion()
        end,
        mode = "i",
        desc = "Accept Super Maven suggestion (alternative)",
      },
    },
  },

  -- Auto-commands for Super Maven
  {
    "supermaven-inc/supermaven-nvim",
    init = function()
      -- Auto-start Super Maven on specific file types
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "lua", "python", "javascript", "typescript", "cs", "dart", "gdscript" },
        callback = function()
          -- Ensure Super Maven is running for these file types
          vim.defer_fn(function()
            local api = require("supermaven-nvim.api")
            if not api.is_running() then
              api.start()
            end
          end, 100)
        end,
      })

      -- Show Super Maven status on startup
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.defer_fn(function()
            local api = require("supermaven-nvim.api")
            if api.is_running() then
              vim.notify("Super Maven is running 🤖", vim.log.levels.INFO)
            else
              vim.notify("Super Maven starting up...", vim.log.levels.INFO)
            end
          end, 2000)
        end,
      })
    end,
  },

  -- Integration with existing completion sources
  {
    "supermaven-inc/supermaven-nvim",
    opts = function(_, opts)
      -- Configure Super Maven to work well with your existing setup
      opts.keymaps = opts.keymaps or {}
      opts.keymaps.accept_suggestion = "<Tab>"
      opts.keymaps.clear_suggestion = "<C-]>"
      opts.keymaps.accept_word = "<C-j>"

      -- Set colors to match Tokyo Night theme
      opts.color = {
        suggestion_color = "#565f89", -- Tokyo Night comment color
        cterm = 244,
      }

      -- Enable for all your development languages
      opts.ignore_filetypes = opts.ignore_filetypes or {}
      -- Uncomment to disable for specific filetypes
      -- opts.ignore_filetypes.markdown = true

      return opts
    end,
  },
}
