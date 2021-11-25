local M = {}
M._fns = {}
local _id = 0
function M.wrap(fn)
  M._fns[_id] = fn
  local map = ":lua require'keymaps'._fns[".._id.."]()<CR>"
  _id = _id + 1
  return map
end
return M
