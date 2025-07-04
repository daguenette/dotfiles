-- ====================================
-- NEOVIM KEYMAPS CONFIGURATION
-- ====================================

-- Default options for keymaps
local opts = { noremap = true, silent = true }

-- Leader key configuration
vim.g.mapleader = " " -- Set space as the leader key
vim.g.maplocalleader = " " -- Set space as the local leader key

-- ====================================
-- VISUAL MODE KEYMAPS
-- ====================================

-- Move selected lines up/down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up in visual selection" })

-- Maintain visual selection when indenting
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Better paste in visual mode (doesn't replace clipboard)
vim.keymap.set("v", "p", '"_dp', opts)

-- ====================================
-- NORMAL MODE KEYMAPS
-- ====================================

-- Join lines without moving cursor
vim.keymap.set("n", "J", "mzJ`z")

-- Page up/down with centered cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move up in buffer with cursor centered" })

-- Search navigation with centered cursor
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Disable Q (ex mode)
vim.keymap.set("n", "Q", "<nop>")

-- Prevent x delete from going to clipboard
vim.keymap.set("n", "x", '"_x', opts)

-- ====================================
-- CLIPBOARD AND PASTE OPERATIONS
-- ====================================

-- Paste without losing clipboard content (x-mode/visual block)
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]], opts)

-- Delete without affecting clipboard
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- ====================================
-- INSERT MODE KEYMAPS
-- ====================================

-- Ctrl+C as Escape alternative
vim.keymap.set("i", "<C-c>", "<Esc>")

-- ====================================
-- SEARCH AND REPLACE
-- ====================================

-- Clear search highlighting
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search highlight", silent = true })

-- Replace word under cursor globally
vim.keymap.set(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word under cursor globally" }
)

-- ====================================
-- FILE OPERATIONS
-- ====================================

-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Copy file path to clipboard
vim.keymap.set("n", "<leader>fp", function()
  local filePath = vim.fn.expand("%:~") -- Get file path relative to home directory
  vim.fn.setreg("+", filePath) -- Copy to system clipboard
  print("File path copied to clipboard: " .. filePath)
end, { desc = "Copy file path to clipboard" })

-- ====================================
-- LSP AND FORMATTING
-- ====================================

-- Format code using LSP
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Toggle LSP diagnostics visibility
local isLspDiagnosticsVisible = true
vim.keymap.set("n", "<leader>lx", function()
  isLspDiagnosticsVisible = not isLspDiagnosticsVisible
  vim.diagnostic.config({
    virtual_text = isLspDiagnosticsVisible,
    underline = isLspDiagnosticsVisible,
  })
end, { desc = "Toggle LSP diagnostics" })

-- ====================================
-- TMUX INTEGRATION
-- ====================================

-- Start new tmux session with sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- ====================================
-- TAB MANAGEMENT
-- ====================================

vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- ====================================
-- SPLIT WINDOW MANAGEMENT
-- ====================================

vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- ====================================
-- AUTOCOMMANDS
-- ====================================

-- Highlight yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
