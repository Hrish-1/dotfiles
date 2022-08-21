local keymaps = require('user.lsp.keymaps')
local cmp = require('cmp_nvim_lsp')

local opts = {
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
    keymaps.setup(client, bufnr)
  end,

  capabilities = cmp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  flags = {
    debounce_text_changes = 150,
  },
}

local servers = { 'gopls', 'clangd', 'tsserver' }
local lsp_config = require('lspconfig')
-- local configs = require('lspconfig/configs')

for _, lsp in pairs(servers) do
  lsp_config[lsp].setup(opts) 
end
