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
    }
    local conflicts = vim.api.nvim_create_augroup('git-conflict', { clear = true })
    vim.api.nvim_create_autocmd({
      'VimEnter',
    }, {
      pattern = '*',
      group = conflicts,
      callback = function()
        if vim.o.diff == true then
          vim.keymap.set('n', '==', '<Cmd>GitConflictChooseBase<CR>', { buffer = true, desc = 'Choose Base' })
          vim.keymap.set('n', '>>', '<Cmd>GitConflictChooseTheirs<CR>', { buffer = true, desc = 'Choose Theirs' })
          vim.keymap.set('n', '<<', '<Cmd>GitConflictChooseOurs<CR>', { buffer = true, desc = 'Choose Ours' })
          vim.keymap.set('n', '<>', '<Cmd>GitConflictChooseBoth<CR>', { buffer = true, desc = 'Choose Both' })
          vim.keymap.set('n', '><', '<Cmd>GitConflictChooseNone<CR>', { buffer = true, desc = 'Choose None' })
          vim.keymap.set('n', ']x', '<Cmd>GitConflictNextConflict<CR>zz', { buffer = true, desc = 'Next Conflict' })
          vim.keymap.set('n', '[x', '<Cmd>GitConflictPrevConflict<CR>zz', { buffer = true, desc = 'Previous Conflict' })
          vim.keymap.set('n', 'Q', '<Cmd>GitConflictListQf<CR>', { buffer = true, desc = 'Conflicts in Quickfix' })
        end
      end,
    })
  end,
}
