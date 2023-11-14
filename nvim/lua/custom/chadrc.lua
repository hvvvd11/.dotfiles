local M = {}
M.ui = {theme = 'jellybeans'}
M.plugins = 'custom.plugins'
M.mappings = require "custom.mappings"

vim.opt.swapfile = false
vim.opt.scrolloff = 8
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.updatetime = 20
vim.opt.wrap = false
return M

