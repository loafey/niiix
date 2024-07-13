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
    "catppuccin/nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim"
})
require('lsp')
require('tree')
require('bar')
require('mason-conf')

vim.cmd.colorscheme "catppuccin-frappe"
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.virtualedit = 'onemore'
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
