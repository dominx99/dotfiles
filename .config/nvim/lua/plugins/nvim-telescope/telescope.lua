require('telescope').setup{
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--no-ignore',
            '-g',
            '!tags'
        },
    }
}

vim.api.nvim_exec([[
    nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
    nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
    nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
    nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
    nnoremap <leader>fs <cmd>lua require('telescope.builtin').grep_string()<cr>
    nnoremap <leader>fr <cmd>lua require('telescope.builtin').lsp_references()<cr>
    nnoremap <leader>fds <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
]], false)
