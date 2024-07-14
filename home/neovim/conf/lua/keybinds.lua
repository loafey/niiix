local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        if opts.desc then
            opts.desc = "keymaps.lua: " .. opts.desc
        end
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

local opts = { noremap = true, silent = true }

map('n','<Up>','<Nop>', opts)
map('n','<Left>','<Nop>', opts)
map('n','<Right>','<Nop>', opts)
map('n','<Down>','<Nop>', opts)

-- Tabs
-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)

-- Telescope
map('n', '<A-h>', '<Cmd>Telescope keymaps<CR>')

-- LazyGit
map('n', '<A-l>', '<Cmd>LazyGit<CR>', opts)

-- Tree
map('n', '<A-t>', '<Cmd>NvimTreeToggle<CR>', opts)
map('n', '<A-g>', '<Cmd>NvimTreeFocus<CR>', opts)


-- Ide
-- vim.lsp.buf.definition()
map('n', '<F3>', '<Cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<F2>', '<Cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<F2>', '<Cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<F2>', '<Cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<F2>', '<Cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<A-x>', '<Cmd>RustLsp expandMacro<CR>')
map('n', '<A-.>', '<Cmd>RustLsp hover actions<CR>')
map('n', '<A-Enter>', '<Cmd>RustLsp codeAction<CR>')
