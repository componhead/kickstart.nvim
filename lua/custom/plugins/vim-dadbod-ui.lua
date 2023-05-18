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
    vim.g.db_ui_auto_execute_table_helpers = 1
    vim.g.db_ui_disable_progress_bar = 0
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_winwidth = 80
    local wk = require 'which-key'
    wk.add {
      { '<leader>cdb', '<cmd>tabnew %<CR><cmd>DBUIToggle<CR><cmd>only<CR>', desc = 'show DBs panel' },
      { '<leader>cdc', '<cmd>DBUIAddConnection<CR>', desc = 'add DB connection' },
      { '<leader>cdf', '<cmd>DBUIFindBuffer<CR>', desc = 'find DB buffer' },
      { '<leader>cdi', '<cmd>DBUILastQueryInfo<CR>', desc = 'last query info' },
      { '<leader>cdr', '<cmd>DBUIRenameBuffer<CR>', desc = 'rename DB buffer' },
    }
  end,
}
