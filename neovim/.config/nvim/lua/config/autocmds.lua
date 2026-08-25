-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local get_hl = vim.api.nvim_get_hl
local set_hl = vim.api.nvim_set_hl

local my_augroup = augroup('my_augroup', {})

autocmd('ColorScheme', {
  group = my_augroup,
  callback = function ()
    set_hl(0, 'Cursor', { reverse = true })

    local code_block = get_hl(0, { name = 'RenderMarkdownCode', link = false })
    set_hl(0, 'RenderMarkdownCodeInline', { bg = code_block.bg })
  end,
  desc = 'set highlight adjustments on colorscheme change'
})
