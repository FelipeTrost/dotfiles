vim.keymap.set('', '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
--[[ vim.keymap.set('n', '<leader>pv', vim.cmd.Ex) ]], { silent = true }

--[[ vim.keymap.set('n', '<leader>e', ':Lex 20<Cr><Cr>') ]], { silent = true }

vim.keymap.set('n', '<C-Up>', ':resize -2<Cr>', { silent = true })
vim.keymap.set('n', '<C-Down>', ':resize +2<Cr>', { silent = true })
vim.keymap.set('n', '<C-Left>', ':vertical resize +2<Cr>', { silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize -2<Cr>', { silent = true })

--[[ vim.keymap.set('n', '<S-l>', ':bprevious<Cr>') ]]

vim.keymap.set('n', '|', ':vsplit<Cr>', { silent = true })

vim.keymap.set('n', '<leader>t', ':set wrap!<Cr>', { silent = true })


vim.keymap.set('v', '<', '<gv', { silent = true })
vim.keymap.set('v', '>', '>gv', { silent = true })
vim.keymap.set('n', '-', ':split<Cr><C-w>j', { silent = true })
vim.keymap.set('v', '|', ':vsplit<Cr><C-w>l', { silent = true })

vim.keymap.set('n', '<C-s>', vim.cmd.w)
vim.keymap.set('i', '<C-s>', function()
  vim.cmd.w();
  vim.cmd.stopinsert();
end)


vim.keymap.set('i', 'jk', '<Esc>l', { silent = true, noremap = true }, { silent = true })
--vim.keymap.set('n', '<C-_>', 'gcc', { silent=true})
--vim.keymap.set('v', '<C-_>', 'gc', { silent=true})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

vim.keymap.set("n", "J", "mzJ`z", { silent = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })
vim.keymap.set("n", "n", "nzzzv", { silent = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true })

-- greatest remap ever (visual mode, { silent=true})
vim.keymap.set("x", "<leader>p", [["_dP]], { silent = true })
--[[ vim.keymap.set('v', 'p', '"_dp') ]]

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>cy", [["+y]], { silent = true })
vim.keymap.set({ "n", "v" }, "<leader>cp", [["+p]], { silent = true })
vim.keymap.set("n", "<leader>Y", [["+Y]], { silent = true })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { silent = true })


vim.keymap.set("n", "Q", "<nop>", { silent = true })
--vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { silent=true})
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { silent = true })

--vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { silent=true})
--vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { silent=true})
--vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { silent=true})
--vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { silent=true})

--vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { silent=true})
--vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true }, { silent=true})

--vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");, { silent=true}
--vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");, { silent=true}

--vim.keymap.set("n", "<leader><leader>", function(, { silent=true})
--    vim.cmd("so", { silent=true})
--end)
--
--[[ function CloseQuickfix()
    vim.lsp.buf.references()
    vim.cmd("autocmd! BufWinLeave <buffer> autocmd QuickFixCmdPost [^l]* cwindow | autocmd! BufWinLeave <buffer>", { silent=true})
end

vim.api.nvim_set_keymap('n', 'q', ':lua CloseQuickfix()<CR>', { noremap = true, silent = true }) ]]

vim.keymap.set("n", "<leader>h", function() vim.cmd("set hlsearch!") end, { silent = true })

vim.keymap.set("n", "<leader>j", ":cnext<Cr>zz", { silent = true })
vim.keymap.set("n", "<leader>k", ":cprevious<Cr>zz", { silent = true })
vim.cmd("hi! link QuickFixLine MatchParen") -- Highlight current item

-- TERMINAL remaps
vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
