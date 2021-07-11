local binds = {
    {'n', '<leader>me', '<CMD>lua _G.my.lua_exec(vim.api.nvim_get_current_line())<CR>'},
    {'v', '<leader>me', '<CMD>lua _G.my.lua_exec(_G.my.visual_selection_text())<CR>'},
}

_G.my.lua_exec = function (s)
    local f, err = loadstring(s)
    if err then
        print(err)
    else
        f()
    end
end

_G.my.visual_selection_range = function ()
  local _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
  local _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
  if csrow < cerow or (csrow == cerow and cscol <= cecol) then
    return csrow - 1, cscol - 1, cerow - 1, cecol
  else
    return cerow - 1, cecol - 1, csrow - 1, cscol
  end
end

_G.my.visual_selection_text = function ()
    local crow, _, erow, _ = _G.my.visual_selection_range()
    local lines = vim.api.nvim_buf_get_lines(0, crow, erow+1, false)
    return table.concat(lines, "\n")
end

require('keybinds').add_binds(binds)
