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
    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        }
    },
    "nvim-lua/lsp-status.nvim",
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    'elentok/format-on-save.nvim',
    'mrcjkb/rustaceanvim',
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'nvim-telescope/telescope.nvim',
    'm4xshen/autoclose.nvim'
})
require('lsp')
require('tree')
require('bar')
require('format')

vim.cmd.colorscheme "catppuccin-frappe"
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.virtualedit = 'onemore'
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"
