return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  lazy = false,
  config = function()
    require('telescope').setup {
      defaults = {
        hidden = true,
        file_ignore_patterns = {
          "node_modules"
        }
      }
    }

    --pcall(require('telescope').load_extension, 'fzf')

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>sf', function() builtin.find_files({ hidden = true }) end, {})
    vim.keymap.set('n', '<leader>sb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>sg', function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end)
    vim.keymap.set('n', '<leader>sw', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })

    vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })

    vim.keymap.set('n', '<leader>sd', builtin.help_tags, {})
  end,
  performance = {
    max_view_entries = 20
  }
}
