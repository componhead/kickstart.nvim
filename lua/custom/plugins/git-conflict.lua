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
      vim.keymap.set('n', '==', '<Cmd>GitConflictChooseBase<CR>', { buffer = true, desc = 'Choose Base' }),
      vim.keymap.set('n', '<RIGHT>', '<Cmd>GitConflictChooseTheirs<CR>', { buffer = true, desc = 'Choose Theirs' }),
      vim.keymap.set('n', '<LEFT>', '<Cmd>GitConflictChooseOurs<CR>', { buffer = true, desc = 'Choose Ours' }),
      vim.keymap.set('n', '=2', '<Cmd>GitConflictChooseBoth<CR>', { buffer = true, desc = 'Choose Both' }),
      vim.keymap.set('n', '=0', '<Cmd>GitConflictChooseNone<CR>', { buffer = true, desc = 'Choose None' }),
      vim.keymap.set('n', '<DOWN>', '<Cmd>GitConflictNextConflict<CR>zz', { buffer = true, desc = 'Next Conflict' }),
      vim.keymap.set('n', '<UP>', '<Cmd>GitConflictPrevConflict<CR>zz', { buffer = true, desc = 'Previous Conflict' }),
      vim.keymap.set('n', '<C-q>', '<Cmd>GitConflictListQf<CR>', { buffer = true, desc = 'Conflicts in Quickfix' }),
    }
  end,
}
