-- Set leaders before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.environment")
