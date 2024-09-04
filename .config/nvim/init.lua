-- print("Hola guapo ")

require("set")
require("globals")
require("remap")

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
    config = function()
      require("nvim-surround").setup()
      vim.api.nvim_set_hl(0, "NvimSurroundHighlight", {
        bg = "#ffffff",
        -- blend = 100,
      })
    end

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
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        pattern = [[.*<(KEYWORDS)\s*]], -- pattern or table of patterns, used for highlighting (vim regex)
      },
    }
  },
  -- sessions add require("persistence").load() to .nvim_config.lua in projects where you want it to be automatic
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {}
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    opts = {
      -- provider_selector = function(bufnr, filetype, buftype)
      --   return { 'treesitter', 'indent' }
      -- end
    }
  },
  require("config.autoformat"),
  -- {
  --   dir = "~/projects/personal/tserrors.nvim",
  --   config = function()
  --     vim.api.nvim_create_user_command('TSErrors', require('tserrors').get_errors, {})
  --   end
  -- },
})


require("config.lsp")
require("config.cmp")
require("config.debugger")

require("workstuff")
require("hello-there")
require("autocmds")
require("kitty-bg-setter")

--[[ Local config for project ]]
local cwd = vim.fn.getcwd()
local configFileName = cwd .. '/.nvim_config.lua'

if vim.fn.filereadable(configFileName) == 1 then
  vim.cmd.source(configFileName)
end
