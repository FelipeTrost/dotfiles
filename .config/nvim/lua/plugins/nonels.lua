return {
  "jay-babu/mason-null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "nvimtools/null-ls.nvim",
  },
  config = function()
    local null_ls = require('null-ls')
    null_ls.setup()

    require("mason").setup()
    require("mason-null-ls").setup({
      ensure_installed = {
        -- Opt to list sources here, when available in mason.
      },
      automatic_installation = false,
      handlers = {},
    })
  end,
}
