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
    vim.keymap.set('n', '<leader>\\l', '<cmd>UrlView lazy<CR>', { desc = 'show lazy plugins links', silent = true })
    vim.keymap.set('n', '<leader>\\u', '<cmd>UrlView buffer<CR>', { desc = 'show links in current buffer', silent = true })
  end,
}
