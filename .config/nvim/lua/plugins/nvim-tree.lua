return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' }
  },
  config = function()
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        width = 50,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    })

    local api = require("nvim-tree.api")
    vim.keymap.set('n', '<leader>e', function()
      api.tree.toggle({ find_file = true })
    end)

    --set relative line numbers
    api.events.subscribe("TreeOpen", function()
      vim.cmd("set rnu")
    end)

    -- Auto close
    vim.api.nvim_create_autocmd("BufEnter", {
      desc = "Auto close nvim tree when entering a buffer",
      callback = function(ev)
        if
            string.find(ev.file, "NvimTree") == nil
            and ev.file ~= ""              -- avoid closing when telescope
            and ev.file ~= vim.fn.getcwd() -- to avoid closing tree when opening nvim
        then
          -- We need to defer if for the case when the tree is taking up the hole window
          -- because closing it alsow causes the buffer we're entering to be closed for some reason
          -- By defering it the buffer opens, the tree moves to the side, and then we close it
          vim.defer_fn(function()
            require("nvim-tree.api").tree.close()
          end, 0)
          return
        end
      end,
    })
  end
}
