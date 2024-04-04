return {
  'nvimdev/lspsaga.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('lspsaga').setup {}
    local wk = require 'which-key'
    wk.register({
      d = { '<cmd>Lspsaga show_workspace_diagnostics<CR>', 'show workspace diagnostics' },
    }, { prefix = '<leader>w' })
  end,
}
