vim.g.mapleader = ' '

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.hlsearch = false
vim.opt.undofile = true
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.encoding = "utf-8"
vim.opt.go = "a"
vim.opt.mouse = "a"
vim.opt.showmode = false

local packer = require("packer")
local plugins = require("plugins")

packer.startup(function(use)
   for _, plugin in ipairs(plugins) do
      use(plugin)
   end
end)

vim.cmd [[
set nocompatible
]]



vim.keymap.set('n', '<Leader>c', [[:w! | !compiler <c-r>%<CR>]], {noremap = true})


local api = vim.api
-- autocommands
--- This function is taken from https://github.com/norcalli/nvim_utils
local function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        api.nvim_command('augroup '..group_name)
        api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            api.nvim_command(command)
        end
        api.nvim_command('augroup END')
    end
end

local autocmds = {
    reload_vimrc = {
        -- Reload vim config automatically
        {"BufWritePost","*picom.conf","!pkill picom; picom -b"};
    };
}

nvim_create_augroups(autocmds)
-- autocommands END
