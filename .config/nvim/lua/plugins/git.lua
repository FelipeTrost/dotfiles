vim.keymap.set('n', '<leader>gs', ':Git<Cr><C-W>L5j', { silent = true })

return {
  'tpope/vim-fugitive',
  {
    "ThePrimeagen/git-worktree.nvim",
    config = function()
      local Worktree = require("git-worktree")

      Worktree.setup()

      require("telescope").load_extension("git_worktree")

      vim.keymap.set('n', '<leader>wt', function()
        require('telescope').extensions.git_worktree.git_worktrees()
      end)

      vim.keymap.set('n', '<leader>tc', function()
        require('telescope').extensions.git_worktree.create_git_worktree()
      end)

      Worktree.on_tree_change(function(op, metadata)
        require("nvim-tree.api").tree.change_root(metadata.path)
      end)
    end
  }
}
