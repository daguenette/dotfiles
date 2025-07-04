-- ====================================
-- PURE OPENCODE THEME
-- ====================================

return {
  -- Pure opencode theme without any base theme conflicts
  {
    "rktjmp/lush.nvim",
    priority = 1000,
    config = function()
      -- opencode theme colors (exact from specification)
      local colors = {
        -- Dark theme colors
        bg = "#0a0a0a", -- darkStep1
        bg_dark = "#0a0a0a", -- darkStep1
        bg_float = "#141414", -- darkStep2
        bg_popup = "#141414", -- darkStep2
        bg_sidebar = "#0a0a0a", -- darkStep1
        bg_statusline = "#0a0a0a", -- darkStep1
        bg_visual = "#1e1e1e", -- darkStep3
        bg_search = "#282828", -- darkStep4

        fg = "#eeeeee", -- darkStep12
        fg_dark = "#808080", -- darkStep11
        fg_gutter = "#484848", -- darkStep7

        -- opencode accent colors
        primary = "#fab283", -- darkStep9 (primary)
        secondary = "#5c9cf5", -- darkSecondary
        accent = "#9d7cd8", -- darkAccent

        -- Semantic colors
        red = "#e06c75", -- darkRed
        orange = "#f5a742", -- darkOrange
        green = "#7fd88f", -- darkGreen
        cyan = "#56b6c2", -- darkCyan
        blue = "#5c9cf5", -- darkSecondary
        purple = "#9d7cd8", -- darkAccent
        yellow = "#e5c07b", -- darkYellow

        -- UI colors
        border = "#484848", -- darkStep7
        comment = "#808080", -- darkStep11
        none = "NONE",
      }

      -- Apply the theme
      local function apply_opencode_theme()
        -- Clear any existing colorscheme
        vim.cmd("highlight clear")
        if vim.fn.exists("syntax_on") then
          vim.cmd("syntax reset")
        end

        vim.o.background = "dark"
        vim.g.colors_name = "opencode"

        local highlights = {
          -- Base
          Normal = { fg = colors.fg, bg = colors.none },
          NormalFloat = { fg = colors.fg, bg = colors.bg_float },
          NormalNC = { fg = colors.fg, bg = colors.none },

          -- UI Elements
          ColorColumn = { bg = colors.bg_visual },
          Cursor = { fg = colors.bg, bg = colors.primary },
          CursorLine = { bg = colors.bg_visual },
          CursorColumn = { bg = colors.bg_visual },
          LineNr = { fg = colors.fg_gutter },
          CursorLineNr = { fg = colors.primary, bold = true },
          SignColumn = { fg = colors.fg_gutter, bg = colors.none },
          Folded = { fg = colors.comment, bg = colors.bg_visual },
          FoldColumn = { fg = colors.comment, bg = colors.none },

          -- Search
          Search = { fg = colors.bg, bg = colors.primary },
          IncSearch = { fg = colors.bg, bg = colors.orange },
          Substitute = { fg = colors.bg, bg = colors.red },

          -- Visual
          Visual = { bg = colors.bg_visual },
          VisualNOS = { bg = colors.bg_visual },

          -- Messages
          ErrorMsg = { fg = colors.red },
          WarningMsg = { fg = colors.yellow },
          ModeMsg = { fg = colors.fg },
          MoreMsg = { fg = colors.green },
          Question = { fg = colors.cyan },

          -- Popup Menu
          Pmenu = { fg = colors.fg, bg = colors.bg_float },
          PmenuSel = { fg = colors.bg, bg = colors.primary },
          PmenuSbar = { bg = colors.bg_visual },
          PmenuThumb = { bg = colors.primary },

          -- Borders
          FloatBorder = { fg = colors.border, bg = colors.none },
          WinSeparator = { fg = colors.border },

          -- Syntax Highlighting (opencode theme)
          Comment = { fg = colors.comment, italic = true },

          Constant = { fg = colors.orange },
          String = { fg = colors.green },
          Character = { fg = colors.green },
          Number = { fg = colors.orange },
          Boolean = { fg = colors.orange },
          Float = { fg = colors.orange },

          Identifier = { fg = colors.red },
          Function = { fg = colors.primary },

          Statement = { fg = colors.purple },
          Conditional = { fg = colors.purple },
          Repeat = { fg = colors.purple },
          Label = { fg = colors.purple },
          Operator = { fg = colors.cyan },
          Keyword = { fg = colors.purple },
          Exception = { fg = colors.purple },

          PreProc = { fg = colors.cyan },
          Include = { fg = colors.cyan },
          Define = { fg = colors.cyan },
          Macro = { fg = colors.cyan },
          PreCondit = { fg = colors.cyan },

          Type = { fg = colors.yellow },
          StorageClass = { fg = colors.yellow },
          Structure = { fg = colors.yellow },
          Typedef = { fg = colors.yellow },

          Special = { fg = colors.cyan },
          SpecialChar = { fg = colors.cyan },
          Tag = { fg = colors.primary },
          Delimiter = { fg = colors.fg },
          SpecialComment = { fg = colors.comment },
          Debug = { fg = colors.red },

          -- Tree-sitter
          ["@keyword"] = { fg = colors.purple },
          ["@keyword.function"] = { fg = colors.purple },
          ["@keyword.operator"] = { fg = colors.purple },
          ["@keyword.return"] = { fg = colors.purple },

          ["@function"] = { fg = colors.primary },
          ["@function.builtin"] = { fg = colors.primary },
          ["@function.call"] = { fg = colors.primary },
          ["@function.macro"] = { fg = colors.cyan },

          ["@variable"] = { fg = colors.red },
          ["@variable.builtin"] = { fg = colors.red },
          ["@variable.parameter"] = { fg = colors.red },
          ["@variable.member"] = { fg = colors.red },

          ["@string"] = { fg = colors.green },
          ["@string.escape"] = { fg = colors.cyan },
          ["@string.special"] = { fg = colors.cyan },

          ["@number"] = { fg = colors.orange },
          ["@boolean"] = { fg = colors.orange },
          ["@constant"] = { fg = colors.orange },
          ["@constant.builtin"] = { fg = colors.orange },

          ["@type"] = { fg = colors.yellow },
          ["@type.builtin"] = { fg = colors.yellow },
          ["@type.definition"] = { fg = colors.yellow },

          ["@operator"] = { fg = colors.cyan },
          ["@punctuation"] = { fg = colors.fg },
          ["@punctuation.bracket"] = { fg = colors.fg },
          ["@punctuation.delimiter"] = { fg = colors.fg },

          ["@comment"] = { fg = colors.comment, italic = true },
          ["@comment.todo"] = { fg = colors.bg, bg = colors.yellow },
          ["@comment.warning"] = { fg = colors.bg, bg = colors.orange },
          ["@comment.error"] = { fg = colors.bg, bg = colors.red },

          -- LSP
          DiagnosticError = { fg = colors.red },
          DiagnosticWarn = { fg = colors.yellow },
          DiagnosticInfo = { fg = colors.cyan },
          DiagnosticHint = { fg = colors.comment },

          DiagnosticUnderlineError = { undercurl = true, sp = colors.red },
          DiagnosticUnderlineWarn = { undercurl = true, sp = colors.yellow },
          DiagnosticUnderlineInfo = { undercurl = true, sp = colors.cyan },
          DiagnosticUnderlineHint = { undercurl = true, sp = colors.comment },

          -- Git
          GitSignsAdd = { fg = colors.green },
          GitSignsChange = { fg = colors.yellow },
          GitSignsDelete = { fg = colors.red },

          -- Telescope
          TelescopeNormal = { fg = colors.fg, bg = colors.none },
          TelescopeBorder = { fg = colors.primary, bg = colors.none },
          TelescopePromptNormal = { fg = colors.fg, bg = colors.bg_float },
          TelescopePromptBorder = { fg = colors.primary, bg = colors.bg_float },
          TelescopePromptTitle = { fg = colors.bg, bg = colors.primary },
          TelescopePreviewTitle = { fg = colors.bg, bg = colors.green },
          TelescopeResultsTitle = { fg = colors.bg, bg = colors.purple },
          TelescopeSelection = { fg = colors.fg, bg = colors.bg_visual },
          TelescopeSelectionCaret = { fg = colors.primary },

          -- Neo-tree
          NeoTreeNormal = { fg = colors.fg, bg = colors.none },
          NeoTreeNormalNC = { fg = colors.fg, bg = colors.none },
          NeoTreeDirectoryName = { fg = colors.primary },
          NeoTreeDirectoryIcon = { fg = colors.primary },
          NeoTreeFileName = { fg = colors.fg },
          NeoTreeFileIcon = { fg = colors.cyan },
          NeoTreeGitAdded = { fg = colors.green },
          NeoTreeGitModified = { fg = colors.yellow },
          NeoTreeGitDeleted = { fg = colors.red },
          NeoTreeGitUntracked = { fg = colors.orange },

          -- Which-key
          WhichKey = { fg = colors.primary },
          WhichKeyGroup = { fg = colors.cyan },
          WhichKeyDesc = { fg = colors.fg },
          WhichKeySeperator = { fg = colors.comment },
          WhichKeyFloat = { bg = colors.bg_float },
          WhichKeyBorder = { fg = colors.border },
          
          -- Status line
          StatusLine = { fg = colors.fg, bg = colors.bg },
          StatusLineNC = { fg = colors.comment, bg = colors.bg },
        }

        -- Apply all highlights
        for group, opts in pairs(highlights) do
          vim.api.nvim_set_hl(0, group, opts)
        end
      end

      -- Apply the theme
      apply_opencode_theme()
    end,
  },
}
