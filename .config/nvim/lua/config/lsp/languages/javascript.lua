local on_attach = require("config.lsp.on-attach")

return {
  'pmizio/typescript-tools.nvim',
  config = function()
    require("typescript-tools").setup({
      on_attach = on_attach,
      settings = {
        tsserver_locale = "en",
        jsx_close_tag = {
          enable = true,
          filetypes = { "javascriptreact", "typescriptreact" },
        }
      },
    })
  end
}
