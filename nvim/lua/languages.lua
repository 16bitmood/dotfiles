----------------------------------------------------------------------------
-- LSP
local lspinstall = require('lspinstall')
local lspconfig = require('lspconfig')
-- local lsp_status = require('lsp-status')
-- lsp_status.register_progress()

-- keymaps
local on_attach = function(client, bufnr)
    local lsp_binds = require('keybinds').lsp_binds
    local lsp_binds_conditional = require('keybinds').lsp_binds_conditional
    local add_binds = require('keybinds').add_binds

    add_binds(lsp_binds, nil,  false)
    -- require("lsp_signature").on_attach()

    for _,f in pairs(lsp_binds_conditional) do
        add_binds({f(client)}, nil, false)
    end
    local is_loaded, pkg = pcall(require, 'which-key')
    if is_loaded then pkg.setup() end
end

-- Configure lua language server for neovim development
local lua_settings = {
    Lua = {
        runtime = {
            -- LuaJIT in the case of Neovim
            version = 'LuaJIT',
            path = vim.split(package.path, ';'),
        },
        diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
        },
        workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
            },
        },
    }
}

-- config that activates keymaps and enables snippet support
local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            'documentation',
            'detail',
            'additionalTextEdits',
        }
    }
    return {
        -- enable snippet support
        capabilities = capabilities,
        -- map buffer local keybindings when the language server attaches
        on_attach = on_attach,
    }
end

-- lsp-install
local function setup_servers()
    lspinstall.setup()

    -- get all installed servers
    local servers = lspinstall.installed_servers()
    -- ... and add manually installed servers
    -- table.insert(servers, "clangd")

    for _, server in pairs(servers) do
        local config = make_config()

        -- language specific config
        if server == "lua" then
            config.settings = lua_settings
        end

        lspconfig[server].setup(config)
    end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
lspinstall.post_install_hook = function ()
    setup_servers() -- reload installed servers
    vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

----------------------------------------------------------------------------
-- Languages
----------------------------------------------------------------------------
---- Rust
local opts = {
    tools = {
        autoSetHints = true,
        hover_with_actions = true,

        runnables = {
            use_telescope = true
        },

        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "<-",
            other_hints_prefix  = "=>",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
        },
    },
    server = {on_attach = on_attach},
}

require('rust-tools').setup(opts)

----------------------------------------------------------------------------
