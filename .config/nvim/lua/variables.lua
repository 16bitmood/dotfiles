----

-- General
vim.g.mapleader = ' '
vim.b.mapleader = ' '
vim.o.hidden = true -- Hide buffers instead of closing them
vim.o.fileencoding = "utf-8" -- Encode in utf-8 always
vim.o.mouse = "a" -- Enable Mouse
vim.o.splitbelow = true -- Horizontal splits will automatically be below
vim.o.splitright = true -- Vertical splits will automatically be to the right
vim.o.updatetime = 500 -- Faster completion
vim.o.timeoutlen = 400 -- By default timeoutlen is 1000 ms
vim.o.clipboard = "unnamedplus" -- Copy paste between vim and everything else
vim.o.wildmode = "longest:full,full" -- Command Line Completion
vim.o.inccommand = "split" -- Live Substitution with results in split menu
vim.o.completeopt = "menu,preview,noinsert"
vim.cmd('filetype plugin on') -- filetype detection
-- vim.cmd('setlocal spell')
-- vim.cmd('set spelllang=en_us')

-- Visual
vim.o.termguicolors = true -- set term gui colors most terminals support this
vim.o.title = false
vim.wo.wrap = true -- Show multiple lines for a single long line
vim.o.pumheight = 15 -- Popup menu height
vim.o.conceallevel = 0 -- So that I can see `` in markdown files
vim.wo.cursorline = true -- Enable highlighting of the current line
vim.o.showtabline = 0
vim.o.showmode = false
vim.wo.number = true -- set numbered lines
vim.wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
-- vim.wo.relativenumber = true -- set relative number
vim.cmd('set colorcolumn=99999') -- Indent Line fix -- TODO: Remove

-- Editing/Movement
vim.cmd('set iskeyword+=-') -- Treat - as word seperator
vim.cmd('set iskeyword+=_') -- Treat _ as word seperator
vim.cmd('set whichwrap+=<,>,[,]') -- move to next line with theses keys
vim.cmd('set ts=4') -- Insert 4 spaces for a tab
vim.cmd('set sw=4') -- Change the number of space characters inserted for indentation
vim.cmd('set expandtab') -- Converts tabs to spaces
vim.cmd('set formatoptions-=o') -- Don't Continue Comments
vim.cmd('set formatoptions-=r') -- Don't Continue Comments
vim.bo.smartindent = true -- Makes indenting smart
-- vim.o.backup = false -- This is recommended by coc
-- vim.o.writebackup = false -- This is recommended by coc
