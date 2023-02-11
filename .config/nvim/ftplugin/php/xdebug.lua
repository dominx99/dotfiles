local dap = require('dap')

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/home/domin/.tools/xdebug/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9003,
    pathMappings = {
      ['/application'] = '/workspace/comote/np/source/newspaper_promotions',
      ['/application/crawler/crawler.php'] = '/workspace/comote/fcw/source/crawler.php',
      ['/application/test'] = '/workspace/price-comparison/api'
    }
  }
}
