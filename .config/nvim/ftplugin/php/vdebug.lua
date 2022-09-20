local vdebug_options = {
  port = 9003,
  path_maps = {
    ['/application'] = '/workspace/comote/np/source/newspaper_promotions'
  },
}

local current_vdebug_options = vim.g.vdebug_options

for k,v in pairs(vdebug_options) do current_vdebug_options[k] = v end

vim.g.vdebug_options = current_vdebug_options;
