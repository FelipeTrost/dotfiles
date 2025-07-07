local servers = {
  clangd = {},
  tsserver = {},
  bashls = { filetypes = { 'sh', 'zsh', '' } },
  html = { filetypes = { 'html', 'twig', 'hbs' } },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
}

require('mason').setup()
require('mason-lspconfig').setup({
  -- Mason lspconfig is basically just being used to ensure the servers are installed
  ensure_installed = vim.tbl_keys(servers),
  automatic_enable = false
})

-- Configure and enable servers
local on_attach = require("config.lsp.on-attach")
local installed = require("mason-registry").get_installed_packages()
local capabilities = vim.lsp.protocol.make_client_capabilities()

for _, server in ipairs(installed) do
  local server_name = server.name
  if server.spec and server.spec.neovim and server.spec.neovim.lspconfig then
    server_name = server.spec.neovim.lspconfig
  end

  if server_name == "typescript-tools" then
    goto continue
  end

  local opts = {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }

  vim.lsp.config(server_name, opts)
  vim.lsp.enable(server_name)

  ::continue::
end

