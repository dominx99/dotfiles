local wrap = require 'keymaps'.wrap

local map = function(mode, key, result)
  vim.api.nvim_buf_set_keymap(0, mode, key, result, {noremap = true})
end

local currentLine2 = function()
    local linenr = vim.api.nvim_win_get_cursor(0)[1]
    print(string.format("Current line [%d]",
           linenr))
end

local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local previewers = require "telescope.previewers"
local make_entry = require "telescope.make_entry"
local conf = require("telescope.config").values
local action_set = require "telescope.actions.set"

local opts = {}

function my_custom_picker(results)
    local ctags_file = opts.ctags_file or "tags"

      if not vim.loop.fs_open(vim.fn.expand(ctags_file, true), "r", 438) then
        print "Tags file does not exists. Create one with ctags -R"
        return
      end

      local fd = assert(vim.loop.fs_open(vim.fn.expand(ctags_file, true), "r", 438))
      local stat = assert(vim.loop.fs_fstat(fd))
      local data = assert(vim.loop.fs_read(fd, stat.size, 0))
      assert(vim.loop.fs_close(fd))

      local results = vim.split(data, "\n")

      pickers.new(opts, {
        prompt_title = "Tags",
        finder = finders.new_table {
          results = results,
          entry_maker = opts.entry_maker or make_entry.gen_from_ctags(opts),
        },
        previewer = previewers.ctags.new(opts),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function()
          action_set.select:enhance {
            post = function()
              local selection = action_state.get_selected_entry()

              if selection.scode then
                local scode = string.gsub(selection.scode, "[$]$", "")
                scode = string.gsub(scode, [[\\]], [[\]])
                scode = string.gsub(scode, [[\/]], [[/]])
                scode = string.gsub(scode, "[*]", [[\*]])

                vim.cmd "norm! gg"
                vim.fn.search(scode)
                vim.cmd "norm! zz"
              else
                vim.api.nvim_win_set_cursor(0, { selection.lnum, 0 })
              end
            end,
          }
          return true
        end,
      }):find()
end

map('n', '<leader>k', "<cmd>lua require('functions.test').currentLine()<CR>")
map('n', '<leader>j', wrap(my_custom_picker))
