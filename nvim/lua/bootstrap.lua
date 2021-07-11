-- Bootstrap Packer (https://github.com/wbthomason/packer.nvim#bootstrapping)
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

-- Helper Functions
DEBUG = function (s,title)
    -- TODO: add dependencies
    local Notify = require('lgi').require('Notify')
    local t = title or '[nvim-debug]'
    Notify.init(t)
    Notify.Notification.new(t, require("inspect")(s)):show()
end
