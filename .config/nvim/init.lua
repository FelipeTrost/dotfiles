-- print("Hola guapo ")

require("globals")
require("remap")
require("set")

--[[ Plugins ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require("plugins.lsp"),
  require("plugins.nonels"),
  require("plugins.nvim-cmp"),
  require("plugins.git"),
  require("plugins.treesitter"),
  require("plugins.telescope"),
  require("plugins.lualine"),
  require("plugins.copilot"),
  require("plugins.harpoon"),
  require("plugins.debugger"),
  require("plugins.nvim-tree"),
  require("plugins.theme"),
  require("plugins.theme"),
  -- {
  --   -- Add indentation guides even on blank lines
  --   'lukas-reineke/indent-blankline.nvim',
  --   main = 'ibl',
  --   opts = {},
  -- },
  --{ "davidosomething/format-ts-errors.nvim" },
  {
    "kylechui/nvim-surround",
    opts = {}
  },
  { "christoomey/vim-tmux-navigator" },
  { "m4xshen/autoclose.nvim",        opts = {} },
  { "numToStr/Comment.nvim",         opts = { toggler = { line = "<C-_>" }, opleader = { line = "<C-_>" } } },
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,        -- add a border to hover docs and signature help
      },
      notify = {
        enabled = false,
      },
      messages = {
        enabled = false,
      }
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
    }
  },
  require("config.autoformat"),
  require("config.debugger"),
})

require("config.lsp")
require("config.cmp")

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight copied text",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
  end,
})

require("hello-there")

--[[ Local config for project ]]
local cwd = vim.fn.getcwd()
local configFileName = cwd .. '/.nvim_config.lua'

if vim.fn.filereadable(configFileName) == 1 then
  vim.cmd.source(configFileName)
end
