return {
  'axieax/urlview.nvim',
  config = function()
    require('urlview').setup {
      default_action = 'system',
      jump = {
        prev = '[U',
        next = ']U',
      },
    }
    local wk = require 'which-key'
    wk.add {
      {
        '<leader>\\l',
        '<cmd>UrlView lazy<CR>',
        desc = 'show lazy plugins links',
        silent = true,
      },
      {
        '<leader>\\u',
        '<cmd>UrlView buffer<CR>',
        desc = 'show links in current buffer',
        silent = true,
      },
    }
  end,
}
