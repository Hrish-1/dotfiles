local set = vim.opt

-- Set the behavior of tab
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true
set.relativenumber = true

-- Enable mouse 
set.mouse = "a"

-- Nvim-Tree colour stuff
vim.cmd[[set termguicolors]]

-- Theme
vim.g.tokyonight_italic_keywords = false
vim.g.tokyonight_italic_comments = false
vim.g.tokyonight_style = "night"
vim.cmd[[colorscheme tokyonight]]
