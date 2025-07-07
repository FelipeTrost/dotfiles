require("set")
require("globals")
require("remap")

-- LAZY bootstrap
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
  require("config.nonels"),
  require("config.git"),
  require("config.treesitter"),
  require("config.telescope"),
  require("config.lualine"),
  require("config.copilot"),
  require("config.harpoon"),
  require("config.debugger.debugger"),
  require("config.nvim-tree"),
  require("config.theme"),
  require("config.theme"),
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
      vim.api.nvim_set_hl(0, "NvimSurroundHighlight", {
        bg = "#ffffff",
      })
    end

  },
  { "christoomey/vim-tmux-navigator" },
  {
    "numToStr/Comment.nvim",
    opts = { toggler = { line = "<C-_>" }, opleader = { line = "<C-_>" } }
  },
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
      "MunifTanjim/nui.nvim",
    }
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        pattern = [[.*<(KEYWORDS)\s*]], -- pattern or table of patterns, used for highlighting (vim regex)
      },
    }
  },
  {
    -- for sessions add require("persistence").load() to .nvim_config.lua in projects where you want it to be automatic
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {}
  },
  require("config.lsp.lsp"),
})


require("hello-there")
require("autocmds")

vim.notify = function() end

--[[ Local config for project ]]
local cwd = vim.fn.getcwd()
local configFileName = cwd .. '/.nvim_config.lua'

if vim.fn.filereadable(configFileName) == 1 then
  vim.cmd.source(configFileName)
end
