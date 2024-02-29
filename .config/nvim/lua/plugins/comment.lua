return {
    'numToStr/Comment.nvim',
    opts = {
        toggler = {
            ---Line-comment toggle keymap
            line = '<C-_>',
            ---Block-comment toggle keymap
            block = '<C-_>',
        },
        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
            ---Line-comment keymap
            line = '<C-_>',
            ---Block-comment keymap
            block = '<C-_>',
        },
    }
}
