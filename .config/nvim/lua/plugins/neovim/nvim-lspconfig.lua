local nvim_lsp = require('lspconfig')

local mapper = function(mode, key, result)
  vim.api.nvim_buf_set_keymap(0, mode, key, result, {noremap = true, silent = true})
end

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  mapper('n', 'gd', "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>")
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  mapper('n', 'gi', "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>")
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  mapper('n', 'gr', "<cmd>lua require('telescope.builtin').lsp_references()<CR>")
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  mapper('n', '<space>d', "<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>")
  mapper('n', '<space>wd', "<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<CR>")
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- buf_set_keymap('n', '<M-e>', "<cmd> lua require('telescope.builtin').buffers()<CR>")
  -- buf_set_keymap('n', "<leader>ff', '<cmd> lua require('telescope.builtin').find_files()<CR>")
  -- buf_set_keymap('n', "<leader>fg', '<cmd> lua require('telescope.builtin').live_grep()<CR>")
  -- buf_set_keymap('n', "<leader>fh', '<cmd> lua require('telescope.builtin').help_tags()<CR>")

  mapper('n', '<m-r>', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>")
  mapper('n', '<m-R>', "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
  mapper('n', '<space>ca', "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>")
  mapper('n', '<space>rca', "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>")

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
        hi LspDiagnosticsSignError guifg=Red
        hi LspDiagnosticsSignWarning guifg=Yellow
        hi LspDiagnosticsSignInformation guifg=Blue
        hi LspDiagnosticsSignHint guifg=Green
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = { "intelephense", "tsserver", "clangd", "dartls"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

-- nvim_lsp['phpactor'].setup{
--   on_attach = on_attach 
-- }

-- nvim_lsp["groovyls"].setup {
--   cmd = {'java', '-jar', '/home/domin/.tools/groovy-language-server/build/libs/groovy-language-server-all.jar'},
--   on_attach = on_attach,
-- }

-- nvim_lsp["jdtls"].setup {
--   on_attach = on_attach,
--   cmd = {'jdtls'},
--   init_options = {
--     jvm_args = {},
--     workspace = "/workspace"
--   }
-- }

nvim_lsp["java_language_server"].setup {
  on_attach = on_attach,
  cmd = {'java-language-server'}
}

nvim_lsp["zeta_note"].setup {
  on_attach = on_attach,
  cmd = {'/home/domin/.cargo/bin/zeta-note'}
}
