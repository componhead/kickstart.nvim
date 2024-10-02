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
    vim.g.db_ui_save_location = vim.fn.stdpath('data') .. '/dadbod'

    vim.g.dbs = {
      { name = 'TREE DB Forestry',
        url =  'mysql://' .. vim.env.TREEDOM_DB_USER .. ':' .. vim.env.TREEDOM_DB_TREES_TEST_PASSWORD .. '@' .. vim.env.TREEDOM_DB_TREES_TEST_URL .. ':' .. vim.env.TREEDOM_DB_PORT .. '/'
      },
      { name = 'TEST',
        url =  'mysql://' .. vim.env.TREEDOM_DB_USER .. ':' .. vim.env.TREEDOM_DB_TREES_TEST_PASSWORD .. '@' .. '127.0.0.1:3306/forestry'
      },
      { name = 'Trees-prod',
        url =  'mysql://' .. vim.env.TREEDOM_DB_USER .. ':' .. vim.env.TREEDOM_DB_TREES_PROD_PASSWORD .. '@' .. vim.env.TREEDOM_DB_TREES_PROD_URL .. ':' .. vim.env.TREEDOM_DB_PORT .. '/'
      },
    }
  end
}
