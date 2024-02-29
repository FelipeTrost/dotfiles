-- Open a greeting screen if nvim was opened with no file

if next(vim.fn.argv()) ~= nil and vim.fn.argv()[1] ~= '.' then
  -- neovim was opened with files
  P(vim.fn.argv())
  return
end

-- Open nvim tree
-- require("nvim-tree.api").tree.open()

-- Create buffer

local current_win = vim.api.nvim_get_current_win()
-- local current_win = 0
local buffer_handle = vim.api.nvim_create_buf(false, true)
local greeting_namespace = vim.api.nvim_create_namespace("greeting")

if buffer_handle == 0 then
  return
end

-- vim.api.nvim_win_set_buf(current_win, buffer_handle)
vim.cmd("setlocal nonumber norelativenumber")

-- Greeting message
local greeting = {
  "",
  "",
  "",
  "",
  "██╗  ██╗ ██████╗ ██╗      █████╗           ",
  "██║  ██║██╔═══██╗██║     ██╔══██╗          ",
  "███████║██║   ██║██║     ███████║          ",
  "██╔══██║██║   ██║██║     ██╔══██║          ",
  "██║  ██║╚██████╔╝███████╗██║  ██║          ",
  "╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝          ",
  "                                           ",
  " ██████╗ ██╗   ██╗ █████╗ ██████╗  ██████╗ ",
  "██╔════╝ ██║   ██║██╔══██╗██╔══██╗██╔═══██╗",
  "██║  ███╗██║   ██║███████║██████╔╝██║   ██║",
  "██║   ██║██║   ██║██╔══██║██╔═══╝ ██║   ██║",
  "╚██████╔╝╚██████╔╝██║  ██║██║     ╚██████╔╝",
  " ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝      ╚═════",
  "",
  vim.fn.getcwd(),
  "",
  "",
  "",
  "",
  "",
  "  f  open file",
  "󰊢  t  git worktrees",
  "󰄛  c  miauu"
}

local function padding(str)
  local win_width = vim.api.nvim_win_get_width(0)
  local string_len = 43 -- have to do it this way because lua measures size by bytes
  local left_padding = math.floor((win_width - string_len) / 2)
  return string.rep(" ", left_padding) .. str
end

local function padd_lines(tbl)
  local t = {}
  for k, v in pairs(tbl) do
    t[k] = padding(v)
  end
  return t
end

vim.api.nvim_buf_set_lines(buffer_handle, 0, -1, false, padd_lines(greeting))

local colors = {
  "#5ebd3e",
  "#ffb900",
  "#f78200",
  "#e23838",
  "#973999",
  "#009cdf"
}

local message_start = 4
local message_end = 16

local step = math.floor((message_end - message_start) / #colors)
local current = message_start

for k, v in pairs(colors) do
  local hl_name = string.sub(v, 2)
  vim.api.nvim_set_hl(0, hl_name, { fg = v })

  for i = current, current + step do
    vim.api.nvim_buf_add_highlight(buffer_handle, -1, hl_name, i, 0, -1)
  end
  current = current + step
end


-- Keymaps

vim.keymap.set("n", "f", function() require('telescope.builtin').find_files({ hidden = true }) end,
  { buffer = buffer_handle })

vim.keymap.set("n", "c", function()
    vim.api.nvim_buf_set_extmark(buffer_handle, greeting_namespace, #greeting - 1, 0, {
      id = 1,
      virt_text = { { "miau miau miau miau", "IncSearch" } },
    })

    vim.defer_fn(function()
      vim.api.nvim_buf_set_extmark(buffer_handle, greeting_namespace, #greeting - 1, 0, {
        id = 1,
        virt_text = { { "", } },
      })
    end, 1000)
  end,
  { buffer = buffer_handle })

vim.keymap.set('n', 't', function()
  require('telescope').extensions.git_worktree.git_worktrees()
end, { buffer = buffer_handle })
