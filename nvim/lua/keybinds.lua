-- Helper
local add_binds = function (binds, opts, bufnr)
    local _opts = opts or { noremap = true, silent = false }
    for _, v in pairs(binds) do
        if bufnr == nil then
            vim.api.nvim_set_keymap(v[1], v[2], v[3], _opts)
        else
            vim.api.nvim_buf_set_keymap(bufnr, v[1], v[2], v[3], _opts)
        end
    end
end

local global_binds = {
    -- {mode, bind, expansion}
    -- Normal Mode
    { 'n', 'Y', 'y$'}, -- Default Y is just yy
    { 'n', 'U', '<C-r>'}, -- Redo
    { 'n', '<esc>', '<cmd>nohl<CR><esc>'},
    { 'n', '<tab>', '<cmd>bn<CR>'},
    { 'n', '<s-tab>', '<cmd>bp<CR>'},


    { 'n', '<F2>', '<cmd>ToggleTerm<CR>'},
    { 'n', '<leader>`', '<cmd>ToggleTerm<CR>'},
    { 'n', '<F3>', '<cmd>NvimTreeToggle<CR>'},
    { 'n', '<leader>t', '<cmd>NvimTreeToggle<CR>'},

    { 'n', '<leader>mr', '<cmd>MySyncAndRestartConfig<CR>'}, -- Reload Config
    { 'n', '<leader>mz', '<cmd>MyZenModeToggle<CR>'}, --  Zen Mode Toggle
    { 'n', '<leader>mn', '<cmd>MyOpenTodaysNote<CR>'}, -- Todays Entry

    { 'n', '<leader>w', '<C-w>'},
    { 'n', '<leader>s', '<cmd>update<CR>' },
    { 'n', '<leader><tab>', '<cmd>b#<CR>' },
    { 'n', '<leader>Q', '<cmd>conf q<CR>' },
    { 'n', '<leader>q', '<cmd>bd<CR>' },

    -- Telescope Commands
    { 'n', '<leader>ox', '<cmd>Telescope commands<CR>' },
    { 'n', '<leader>of', '<cmd>Telescope find_files<CR>' },
    { 'n', '<leader>op', '<cmd>Telescope project<CR>' },
    { 'n', '<leader>og', '<cmd>Telescope live_grep<CR>' },
    { 'n', '<leader>or', '<cmd>Telescope live_grep<CR>' },
    { 'n', '<leader>om', '<cmd>Telescope marks<CR>' },
    { 'n', '<leader>ob', '<cmd>Telescope buffers<CR>' },
    -- { 'n', '<leader>os', '<cmd>SearchSession<CR>' }, -- TODO: make 


    -- Terminal Mode
    { 't', '<F2>', '<C-\\><C-n><cmd>ToggleTerm<CR>'},
    { 't', '<esc><esc>', '<C-\\><C-n>' },
    -- { 't', '``', '<C-\\><C-n><cmd>ToggleTerm<CR>' }, -- TODO: Check if this is okay (P.S. its not -_-)
}

local lsp_binds = {
    { 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>' },
    { 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>' },
    { 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>' },
    { 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>' },
    { 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>' },
    { 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>' },
    { 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>' },
    { 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>' },
    -- { 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>' },
    -- { 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>' },
    -- { 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>' },
    { 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>' },
    -- { 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>' },
    -- { 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>' },
    -- { 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>' },
    -- { "n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>" },
}

local lsp_binds_conditional = {
    function (client)
        if client.resolved_capabilities.document_formatting then
            return {"n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>"}
        elseif client.resolved_capabilities.document_range_formatting then
            return {"n", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>"}
        end
    end,
}

local is_prior_char_whitespace = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 or vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
        return vim.api.nvim_replace_termcodes("<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>", true, true, true)
    elseif is_prior_char_whitespace() then
        return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)

    else
        return vim.fn['compe#complete']()
    end
end


_G.s_tab_complete = function()
    if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
        return vim.api.nvim_replace_termcodes("<C-R>=UltiSnips#JumpBackwards()<CR>", true, true, true)
    else
        return vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true)
    end
end

add_binds (
    {
        {"i", "<Tab>", "v:lua.tab_complete()"},
        {"s", "<Tab>", "v:lua.tab_complete()"},
        {"i", "<S-Tab>", "v:lua.s_tab_complete()"},
        {"s", "<S-Tab>", "v:lua.s_tab_complete()"},
    },
    {noremap=true, expr=true}
)

add_binds (
    {
        {"i", "<C-Space>", "compe#complete()"},
        {"i", "<C-e>", "compe#close()"},
        {"i", "<C-f>", "compe#scroll({ 'delta': +4 })"},
        {"i", "<C-d>", "compe#scroll({ 'delta': -4 })"},
    },
    {noremap=true, expr=true, silent=true}
)

-- Add Global Binds
add_binds(global_binds)

return {
    global_binds = global_binds,
    lsp_binds = lsp_binds,
    lsp_binds_conditional = lsp_binds_conditional,
    add_binds = add_binds
}
