local function mapper(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true})
end

mapper('n', '<space>q', ':Trouble<CR>')

-- Dap
mapper('n', '<space>dc', "<cmd>lua require'telescope'.extensions.dap.commands{}<CR>")
mapper('n', '<space>dt', "<cmd>lua require('dapui').toggle()<CR>")

-- Telescope
mapper("n", "<M-e>", "<cmd>lua require('telescope.builtin').buffers()<CR>")
mapper("n", "<M-x>", "<cmd>lua require('telescope.builtin').commands()<CR>")
mapper("n", "<space>k", "<cmd>lua require('telescope.builtin').keymaps()<CR>")
mapper("n", "<M-p>", "<cmd>lua require('telescope.builtin').find_files()<CR>")
mapper("n", "<M-f>", "<cmd>lua require('telescope.builtin').live_grep()<CR>")
mapper("n", "<C-]>", "<cmd>lua require('telescope.builtin').grep_string()<CR>")
