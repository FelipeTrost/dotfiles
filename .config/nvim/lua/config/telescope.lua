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
        },
        path_display = {
          truncate = 1
        }
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      }
    }

    --pcall(require('telescope').load_extension, 'fzf')

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>sf', function() builtin.find_files({ hidden = true }) end, {})
    vim.keymap.set('n', '<leader>sb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>sg', function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end)
    vim.keymap.set('n', '<leader>sw', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })

    local function get_visual_selection()
      -- Get the start and end positions of the visual selection
      local start_pos = vim.fn.getpos("'<")
      local end_pos = vim.fn.getpos("'>")

      -- Extract the line and column information
      local start_line = start_pos[2]
      local start_col = start_pos[3]
      local end_line = end_pos[2]
      local end_col = end_pos[3]

      -- Handle single-line and multi-line selections
      if start_line == end_line then
        -- Single-line selection
        return vim.api.nvim_buf_get_lines(0, start_line - 1, start_line, false)[1]:sub(start_col, end_col)
      else
        -- Multi-line selection
        local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
        lines[1] = lines[1]:sub(start_col)            -- Trim the first line
        lines[#lines] = lines[#lines]:sub(1, end_col) -- Trim the last line
        return table.concat(lines, "\n")
      end
    end

    -- vim.keymap.set('v', '<leader>sw', function() builtin.grep_string({ search = get_visual_selection() }) end,
    --   { desc = '[S]earch visual selection [G]rep' })

    vim.keymap.set('v', '<leader>sw', '"9y<leader>sg<C-r>9<Cr>', { desc = '[S]earch visual selection [G]rep' })

    vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })

    vim.keymap.set('n', '<leader>sd', builtin.help_tags, {})
  end,
  performance = {
    max_view_entries = 20
  }
}
