return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    local wk = require 'which-key'
    wk.register({
      d = {
        name = '+DB',
        b = { '<cmd>DBUIToggle<CR>', 'show DBs panel' },
        c = { '<cmd>DBUIAddConnection<CR>', 'add DB connection' },
        f = { '<cmd>DBUIFindBuffer<CR>', 'find DB buffer' },
        i = { '<cmd>DBUILastQueryInfo<CR>', 'last query info' },
        r = { '<cmd>DBUIRenameBuffer<CR>', 'rename DB buffer' },
      },
    }, { prefix = '<leader>c' })
  end,
}
