local M = {}

M.ui = {
    theme = 'jellybeans',
    use_nerd_icons = true
}


M.plugins = 'custom.plugins'

M.mappings = require "custom.mappings"

vim.opt.swapfile = false
vim.opt.scrolloff = 8
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.updatetime = 20
vim.opt.wrap = false
vim.opt.ttimeoutlen = 0

vim.diagnostic.config({ virtual_text = { current_line = true } })
vim.o.winborder = 'rounded'

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.c", "*.h" },
    callback = function()
        local view = vim.fn.winsaveview()
        local style = "{BasedOnStyle: LLVM, IndentWidth: 4}"
        vim.cmd(string.format("silent %%!clang-format --style=\"%s\"", style))
        vim.fn.winrestview(view)
    end,
})

-- vim.opt.guifont = "JetBrainsMono Nerd Font:h13"

return M
