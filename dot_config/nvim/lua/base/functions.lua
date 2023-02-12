local function find_tags(name, kinds)
  local tag_list = {}

  for _, entry in ipairs(vim.fn.taglist(name)) do
    if vim.fn.index(kinds, entry.kind) > -1 then
      table.insert(tag_list, entry)
    end
  end

  return tag_list
end

local function jump_to_tag(name, kinds)
  local qflist = {}
  for _, entry in ipairs(find_tags(name, kinds)) do
    local filename = entry.filename
    local pattern = vim.fn.substitute(entry.cmd, '^/\\(.*\\)/$', '\\1', '')

    table.insert(qflist, {filename = filename, pattern = pattern})
  end

  if #qflist == 0 then
    vim.api.nvim_command("echohl Error | echo \"No tags found\" | echohl NONE")
  elseif #qflist == 1 then
    vim.fn.setqflist(qflist)
    vim.api.nvim_command("silent cfirst")
  else
    vim.fn.setqflist(qflist)
    vim.api.nvim_command("copen")
  end
end

local function build_php_namespace()
  local txt1 = vim.fn.substitute(vim.fn.expand("%:r"), '/', '\\', 'g')
  local txt2 = vim.fn.substitute(txt1, '^.*\\(src\\|tests\\)', '\\1', 'g')
  local txt3 = vim.fn.substitute(txt2, 'src', 'App', 'g')
  local txt4 = vim.fn.substitute(txt3, 'tests', 'App\\Tests', 'g')
  local txt5 = vim.fn.substitute(txt4, '.*\\zs\\' .. vim.fn.expand("%:t:r"), '', 'g')

  return txt5
end

vim.api.nvim_command("command! BuildPhpNamespace lua build_php_namespace()")
