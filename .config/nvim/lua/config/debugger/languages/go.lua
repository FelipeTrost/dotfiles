return {
  'leoluz/nvim-dap-go',
  config = function() -- Install golang specific config
    require('dap-go').setup()
  end
}
