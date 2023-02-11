require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "sumneko_lua",
    "rust_analyzer",
    "tsserver",
    "clangd",
    "vimls",
    "html",
    "intelephense",
    "phpactor",
    "terraformls",
  }
})

local nvim_lsp = require('lspconfig')

local mapper = function(mode, key, result)
  vim.api.nvim_buf_set_keymap(0, mode, key, result, {noremap = true, silent = true})
end

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  mapper('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
  mapper('n', 'gd', "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>")
  mapper('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
  mapper('n', 'gi', "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>")
  mapper('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  mapper('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
  mapper('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
  mapper('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
  mapper('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  mapper('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  mapper('n', 'gr', "<cmd>lua require('telescope.builtin').lsp_references()<CR>")
  mapper('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
  mapper('n', '<space>wd', "<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<CR>")
  mapper('n', '<M-r>', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>")
  mapper('n', '<space>ca', "<cmd>lua vim.lsp.buf.code_action()<CR>")
  mapper("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>")

  mapper('n', '<leader>ca', ":ALECodeAction<CR>")
  mapper('n', '<space>q', ':Trouble<CR>')

  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec([[
        hi LspDiagnosticsSignError guifg=Red
        hi LspDiagnosticsSignWarning guifg=Yellow
        hi LspDiagnosticsSignInformation guifg=Blue
        hi LspDiagnosticsSignHint guifg=Green
    ]], false)
  end
end

local servers = {"tsserver", "clangd", "dartls", "vimls", "intelephense", "phpactor", "terraformls", "html"}
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

nvim_lsp["java_language_server"].setup {
  on_attach = on_attach,
  cmd = {'java-language-server'}
}

capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
