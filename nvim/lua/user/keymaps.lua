vim.g.mapleader = " "
local opts = { noremap=true, silent=true }

function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Telescope
map("n", "<space>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
map("n", "<space>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
map("n", "<space>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
map("n", "<space>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)

-- NvimTree
map("n", "<space>e", ":NvimTreeToggle<CR>", opts)
map("n", "<space>r", ":NvimTreeRefresh<CR>", opts)
-- map("n", "f", ":NvimTreeFocus<CR>", opts)

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
map('n', '[e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
map('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
map('i', 'jj', '<Esc>', opts)
