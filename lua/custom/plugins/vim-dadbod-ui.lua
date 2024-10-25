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

    if vim.env.TREEDOM_DB_USER ~= nil then
      vim.g.dbs = {
        { name = 'TUNNELLED (w/o password)',
          url =  'mysql://' .. vim.env.TREEDOM_DB_USER .. '@' .. '127.0.0.1:3306/'
        },
        { name = 'TREE DB TEST',
          url =  'mysql://' .. vim.env.TREEDOM_DB_USER .. ':' .. vim.env.TREEDOM_DB_TREES_TEST_PASSWORD .. '@' .. '127.0.0.1:7001/'
        },
        { name = 'TREES DB PROD',
          url =  'mysql://' .. vim.env.TREEDOM_DB_USER .. ':' .. vim.env.TREEDOM_DB_TREES_PROD_PASSWORD .. '@' .. '127.0.0.1:7011'
        },
        { name = 'TREEDOM DB TEST',
          url =  'mysql://' .. vim.env.TREEDOM_DB_USER .. ':' .. vim.env.TREEDOM_DB_TRD_TEST_PASSWORD .. '@' .. '127.0.0.1:7002/'
        },
        { name = 'TREESDOM DB PROD',
          url =  'mysql://' .. vim.env.TREEDOM_DB_USER .. ':' .. vim.env.TREEDOM_DB_TRD_PROD_PASSWORD .. '@' .. '127.0.0.1:7022'
        },
      }
    end
  end
}
