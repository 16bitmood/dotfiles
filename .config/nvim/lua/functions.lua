_G.my = {
    shell = function (command)
        local handle = io.popen(command)
        local result = handle:read("*a")
        handle:close()
        return result
    end,

    SyncAndRestartConfig = function ()
        _G.my.shell('bash ~/main/src/dotfiles/sync.sh')
        vim.cmd('PackerCompile')
    end,

    ConditionalEval = function (name, args)
        if vim.api.nvim_call_function('exists', {':'..name}) then
            if args then
                vim.cmd(name .. ' ' .. args)
            else
               vim.cmd(name)
            end
        end
    end,

    ZenMode = false,

    ZenModeDisable = function ()
        _G.my.ZenMode = false
        local ev = _G.my.ConditionalEval
        -- ev('IndentBlanklineEnable')
        ev('Goyo')
        ev('Limelight!')
        if not require('gitsigns.config').config.signcolumn then
            ev('Gitsigns', 'toggle_signs')
        end
    end,

    ZenModeEnable = function ()
        _G.my.ZenMode = true
        local ev = _G.my.ConditionalEval
        -- ev('IndentBlanklineDisable')
        ev('Limelight')
        if require('gitsigns.config').config.signcolumn then
            ev('Gitsigns',  'toggle_signs')
        end
        ev('Goyo', '75%x80%')
    end,

    ZenModeRefresh = function ()
        if _G.my.ZenMode then
            _G.my.ZenModeEnable()
        else
            _G.my.ZenModeDisable()
        end
    end,

    ZenModeToggle = function ()
        if _G.my.ZenMode then
            _G.my.ZenModeDisable()
        else
            _G.my.ZenModeEnable()
        end
    end,

    CurrentFile = function ()
        return {
            file_name = vim.api.nvim_eval("expand('%:t')"),
            full_path = vim.api.nvim_eval("expand('%:p')"),
            dir_path  = vim.api.nvim_eval("expand('%:p:h')")

        }
    end,

    notes_dir = '~/main/src/journal',
    OpenTodaysNote = function ()
        local fname = vim.api.nvim_call_function('strftime', {"%y-%m-%d"}) .. '.org'
        local fpath = _G.my.notes_dir .. '/' .. fname
        vim.cmd('e '.. fpath);
    end
}

vim.cmd('command! MySyncAndRestartConfig lua _G.my.SyncAndRestartConfig()')
vim.cmd('command! MyZenModeToggle        lua _G.my.ZenModeToggle()')
vim.cmd('command! MyZenModeDisable       lua _G.my.ZenModeDisable()')
vim.cmd('command! MyZenModeEnable        lua _G.my.ZenModeEnable()')
vim.cmd('command! MyOpenTodaysNote        lua _G.my.OpenTodaysNote()')
