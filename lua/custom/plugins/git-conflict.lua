return {
  'akinsho/git-conflict.nvim',
  version = '*',
  config = function()
    require('git-conflict').setup {
      disable_diagnostics = false,
      default_commands = true, -- disable commands created by this plugin
      list_opener = 'copen',
      debug = false,
      highlights = { -- They must have background color, otherwise the default color will be used
        incoming = 'DiffAdd',
        current = 'DiffText',
      },
      default_mappings = {
        ours = 'c<',
        theirs = 'c>',
        none = 'c0',
        both = 'c2',
        next = ']c',
        prev = '[c',
      },
      vim.keymap.set('n', 'c=', '<Cmd>GitConflictChooseBase<CR>', { buffer = true, desc = 'Choose Base' }),
    }
  end,
}
