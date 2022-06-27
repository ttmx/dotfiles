-- helping out lsp
local vim = vim
vim.g.mapleader = ' '

local opt = vim.opt
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.termguicolors = true
opt.hlsearch = false
opt.undofile = true
opt.clipboard = "unnamedplus"
opt.number = true
opt.encoding = "utf-8"
opt.go = "a"
opt.mouse = "a"
opt.showmode = false

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
vim.keymap.set('n', '<Leader>n', [[<cmd>NvimTreeToggle<CR>]], {noremap = true})
vim.api.nvim_create_user_command('W', [[execute ':silent w !sudo tee % >/dev/null' |:edit!]], { nargs = 0 })

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
