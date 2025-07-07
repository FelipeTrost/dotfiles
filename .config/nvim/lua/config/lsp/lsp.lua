return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require("config.lsp.mason")
      require("config.lsp.autoformat")


      -- Disable notifications
      vim.lsp.handlers['$/progress'] = function()
      end

      -- Styles
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
          -- Use a sharp border with `FloatBorder` highlights
          border = "single"
        }
      )

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = 'rounded',
        }
      )

      vim.diagnostic.config {
        float = { border = "single" }
      }
    end
  },
  require("config.lsp.languages.javascript"),
  require("config.lsp.languages.lua"),
  require("config.lsp.cmp"),
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local trouble = require("trouble")
      trouble.setup({
        auto_refresh = false,
        focus = true,
      })
      vim.keymap.set("n", "<leader>xd", ":Trouble diagnostics<cr>")
      vim.keymap.set("n", "<leader>xd", function()
        trouble.open("diagnostics")
      end)
    end
  },
}
