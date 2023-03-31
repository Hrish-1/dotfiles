local keymaps = require('user.lsp.keymaps')
local cmp = require('cmp_nvim_lsp')
require("nvim-lsp-installer").setup {}

local opts = {
    on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
        vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
        keymaps.setup(client, bufnr)
    end,
    capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    flags = {
        debounce_text_changes = 150,
    },
}

-- Metals config
local metals_config = require("metals").bare_config()

-- Example of settings
metals_config.settings = {
    showImplicitArguments = true,
    excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}

-- Setup lspconfig.
metals_config.capabilities = opts.capabilities
metals_config.on_attach = opts.on_attach
opts.capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    -- NOTE: You may or may not want java included here. You will need it if you
    -- want basic Java support but it may also conflict if you are using
    -- something like nvim-jdtls which also works on a java filetype autocmd.
    pattern = { "scala", "sbt" },
    callback = function()
        require("metals").initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
})

local servers = { 'gopls', 'clangd', 'tsserver', 'sumneko_lua', 'hls' }
local lsp_config = require('lspconfig')

for _, lsp in pairs(servers) do
    lsp_config[lsp].setup(opts)
end

return opts
