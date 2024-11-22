return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Language specific
      { 'j-hui/fidget.nvim',       opts = {} },
      'folke/neodev.nvim',

      'pmizio/typescript-tools.nvim'
    }
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function()
      require("trouble").setup({
        auto_refresh = false,
        focus = true,
      })

      -- vim.api.nvim_create_autocmd("QuickFixCmdPost", {
      --   callback = function()
      --     vim.cmd([[Trouble qflist open]])
      --   end,
      -- })

      -- vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
      -- vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
      -- vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
      -- vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
      -- vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)

      vim.keymap.set("n", "<leader>xd", "Trouble diagnostics")
      vim.keymap.set("n", "gR", "Trouble lsp_references")
    end
  }
}
