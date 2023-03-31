local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = '/home/hrish/.cache/jdt-workspace/' .. project_name
local cmp = require('cmp_nvim_lsp')
local whichkey = require("which-key")

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {

        -- 💀
        'java', -- or '/path/to/java17_or_newer/bin/java'
        -- depends on if `java` is in your $PATH env variable and if it points to the right version.

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        --'-javaagent:' .. '/home/hrish/java-workspace/streams/lombok.jar',
        --'-Xbootclasspath/a:' .. '/home/hrish/java-workspace/streams/lombok.jar',
        "-javaagent:" .. tostring(vim.fn.getenv("LOMBOK_JAR")),
        "-Xbootclasspath/a:" .. tostring(vim.fn.getenv("LOMBOK_JAR")),
        -- 💀
        '-jar', '/home/hrish/jdt-language-server/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
        -- Must point to the                                                     Change this to
        -- eclipse.jdt.ls installation                                           the actual version


        -- 💀
        '-configuration', '/home/hrish/jdt-language-server/config_linux',
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
        -- Must point to the                      Change to one of `linux`, `win` or `mac`
        -- eclipse.jdt.ls installation            Depending on your system.


        -- 💀
        -- See `data directory configuration` section in the README
        '-data', workspace_dir,
    },

    -- 💀
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }),
    capabilities = cmp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

local function keymappings()

    local keymap_l = {
        l = {
            name = "Code",
            r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
            a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
            d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Line Diagnostics" },
            f = { "<cmd>lua vim.lsp.buf.format { async = true }<CR>", "Format Document" },
            i = { "<cmd>LspInfo<CR>", "Lsp Info" },
        },
    }

    local keymap_g = {
        name = "Goto",
        d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
        D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
        s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
        I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
        t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
    }
    whichkey.register(keymap_l, { prefix = "<leader>" })
    whichkey.register(keymap_g, { prefix = "g" })
end

keymappings()

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
