return {
  'akinsho/git-conflict.nvim',
  version = '*',
  config = function()
    require('git-conflict').setup {
      disable_diagnostics = true,
      default_commands = true, -- disable commands created by this plugin
      list_opener = 'copen',
      debug = false,
      highlights = { -- They must have background color, otherwise the default color will be used
        incoming = 'DiffAdd',
        current = 'DiffText',
      },
      default_mappings = false,
      vim.keymap.set('n', '<leader>g=', '<Cmd>GitConflictChooseBase<CR>', { buffer = true, desc = 'Choose Base' }),
      vim.keymap.set('n', '<leader>gt', '<Cmd>GitConflictChooseTheirs<CR>', { buffer = true, desc = 'Choose Theirs' }),
      vim.keymap.set('n', '<leader>go', '<Cmd>GitConflictChooseOurs<CR>', { buffer = true, desc = 'Choose Ours' }),
      vim.keymap.set('n', '<leader>g2', '<Cmd>GitConflictChooseBoth<CR>', { buffer = true, desc = 'Choose Both' }),
      vim.keymap.set('n', '<leader>g0', '<Cmd>GitConflictChooseNone<CR>', { buffer = true, desc = 'Choose None' }),
      vim.keymap.set('n', '<leader>gn', '<Cmd>GitConflictNextConflict<CR>zz', { buffer = true, desc = 'Next Conflict' }),
      vim.keymap.set('n', '<leader>gp', '<Cmd>GitConflictPrevConflict<CR>zz', { buffer = true, desc = 'Previous Conflict' }),
      vim.keymap.set('n', '<leader>gq', '<Cmd>GitConflictListQf<CR>', { buffer = true, desc = 'Conflicts in Quickfix' }),
    }
  end,
}
