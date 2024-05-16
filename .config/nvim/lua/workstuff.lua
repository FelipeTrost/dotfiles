local cwd = vim.fn.getcwd()
if not string.find(cwd, "proceed") then
  return
end


vim.api.nvim_create_user_command('StartMs', function()
  local cwd = vim.fn.getcwd()
  vim.cmd("silent ! tmux new-window -c '" ..
    cwd .. "' \\; send-keys 'yarn install --ignore-engines && yarn dev-ms --turbo' Enter")
end, {})
