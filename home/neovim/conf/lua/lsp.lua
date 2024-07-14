local lsp_status = require('lsp-status')
lsp_status.register_progress()
--local nvim_lsp = require'lspconfig'

local on_attach = function(client)
    -- require'completion'.on_attach(client)
    lsp_status.on_attach(client)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.g.rustaceanvim = {
  server = {
    capabilities = capabilities,
  },
}

-- nvim_lsp.rust_analyzer.setup({
--     on_attach=on_attach,
--     capabilities = lsp_status.capabilities,
--     settings = {
--         ["rust-analyzer"] = {
--             diagnostics = { experimental = true },
--             imports = {
--                 granularity = {
--                     group = "module",
--                 },
--                 prefix = "self",
--             },
--             cargo = {
--                 buildScripts = {
--                     enable = true,
--                 },
--             },
--             checkOnSave = {
--                 command = "clippy",
--             },
--             inlayHints = {
--                 chainingMode = false,
--                 bindingMode = false,
--                 bindingModeHints = false,
--             },
--             procMacro = {
--                 enable = true
--             },
--         }
--     }
-- })

-- Autocomplete
local cmp = require('cmp')
cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
})

require("autoclose").setup()

