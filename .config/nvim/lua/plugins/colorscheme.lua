return {
  -- Tokyo Night theme (matches your tmux theme)
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- Load this theme first
    config = function()
      require("tokyonight").setup({
        style = "night", -- night, storm, day, moon
        light_style = "day", -- Style for light variant
        transparent = true, -- Enable transparency
        terminal_colors = true, -- Configure terminal colors
        cache = true, -- Enable caching for better performance

        styles = {
          comments = { italic = true },
          keywords = { italic = false },
          functions = {},
          variables = {},
          -- Background styles for different window types
          sidebars = "transparent", -- Style for sidebars
          floats = "transparent", -- Style for floating windows
        },

        sidebars = { "qf", "help" }, -- Darker background for these
        day_brightness = 0.3, -- Adjusts brightness for day variant
        hide_inactive_statusline = false,
        dim_inactive = false, -- Don't dim inactive windows
        lualine_bold = false, -- Don't make lualine headers bold

        -- Plugin integrations
        plugins = {
          telescope = true,
          indent_blankline = { enabled = true },
          dashboard = true,
          gitsigns = true,
          nvim_cmp = true,
          treesitter = true,
          notify = true,
          mini = true,
        },

        -- Custom highlight overrides to match tmux tokyo-night
        on_colors = function(colors)
          -- Match the tmux tokyo-night color palette
          colors.bg = colors.none -- Transparent background
          colors.bg_dark = colors.none
          colors.bg_float = colors.none
        end,

        on_highlights = function(hl, c)
          -- Ensure key UI elements match the tmux theme
          hl.Normal = { bg = c.none }
          hl.NormalFloat = { bg = c.none }
          hl.FloatBorder = { bg = c.none }
          hl.FloatTitle = { bg = c.none }

          -- Completion menu styling
          hl.Pmenu = { fg = c.fg_dark, bg = c.none }
          hl.PmenuSel = { fg = c.fg, bg = c.bg_visual }
          hl.PmenuSbar = { bg = c.bg_dark }
          hl.PmenuThumb = { bg = c.blue }

          -- Telescope styling to match theme
          hl.TelescopeNormal = { bg = c.none }
          hl.TelescopeBorder = { fg = c.blue, bg = c.none }
          hl.TelescopePromptNormal = { bg = c.none }
          hl.TelescopePromptBorder = { fg = c.blue, bg = c.none }
          hl.TelescopePromptTitle = { fg = c.bg, bg = c.blue }
          hl.TelescopePreviewTitle = { fg = c.bg, bg = c.green }
          hl.TelescopeResultsTitle = { fg = c.bg, bg = c.purple }
        end,
      })

      -- Set the colorscheme
      vim.cmd("colorscheme tokyonight-night")
    end,
  },
}
