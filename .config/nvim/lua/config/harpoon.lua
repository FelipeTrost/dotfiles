-- Harpoon 2 didn't quite do it for me, it didn't work right away, so why bother?
return {
  "ThePrimeagen/harpoon",
  config = function()
    local harpoon = require("harpoon")
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    harpoon.setup({
      menu = {
        -- why that scaling? I don't know
        width = math.ceil(vim.api.nvim_win_get_width(0) * (3 / 7)),
      }
    })

    vim.keymap.set('n', '<C-e>', function() ui.toggle_quick_menu() end)
    vim.keymap.set('n', '<leader>a', function() mark.add_file() end)

    vim.keymap.set('n', '<M-j>', function() ui.nav_file(1) end)
    vim.keymap.set('n', '<M-k>', function() ui.nav_file(2) end)
    vim.keymap.set('n', '<M-l>', function() ui.nav_file(3) end)
    vim.keymap.set('n', '<M-;>', function() ui.nav_file(4) end)
  end
}
