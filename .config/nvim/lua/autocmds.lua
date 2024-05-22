local id = vim.api.nvim_create_augroup("PersonalAutocmds", {
  clear = true
})

vim.api.nvim_create_autocmd('CmdlineChanged', {
  group = id,
  pattern = '*',
  callback = function()
    if vim.fn.getcmdtype() == '/'
        or vim.fn.getcmdtype() == '?'
        or string.sub(vim.fn.getcmdline(), 1, 2) == 'g/'
        or string.sub(vim.fn.getcmdline(), 1, 3) == 'g!/'
        or string.sub(vim.fn.getcmdline(), 1, 2) == 'v/'
    then
      vim.cmd('set hlsearch')
    else
      vim.cmd('set nohlsearch')
    end
  end
})
-- TODO: move this to remaps, when I decide if I like it
vim.keymap.set("n", "<leader>j", function() vim.cmd('set nohlsearch') end, { silent = true })

-- vim.api.nvim_create_autocmd('CmdlineLeave', {
--   group = id,
--   pattern = '*',
--   callback = function()
--     vim.cmd('set nohlsearch')
--   end
-- })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = id,
  desc = "Highlight copied text",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
  end,
})
