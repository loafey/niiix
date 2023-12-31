require('keybinds')
require('lazy-dl')
require("lazy").setup({
    "neovim/nvim-lspconfig",
    {
         "romgrk/barbar.nvim",
         opts = {
            sidebar_filetypes = {
                NvimTree = true
            }
         }
    },
    "nvim-tree/nvim-web-devicons",
    "nvim-tree/nvim-tree.lua",
    "catppuccin/nvim"
})
require('lsp')
require('tree')
require('bar')

vim.cmd.colorscheme "catppuccin-frappe"
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.virtualedit = 'onemore'
vim.bo.expandtab = true
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
