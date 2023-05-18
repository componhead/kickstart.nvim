return {
  'nvim-telescope/telescope-live-grep-args.nvim',
  dependencies = {
    {
      'nvim-telescope/telescope.nvim',
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = '^1.0.0',
    },
  },
  config = function()
    require('telescope').setup {
      extensions = {
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          mappings = {
            i = {
              ['<C-k>'] = require('telescope-live-grep-args.actions').quote_prompt(),
              ['<C-i>'] = require('telescope-live-grep-args.actions').quote_prompt { postfix = ' --iglob ' },
            },
          },
        },
      },
    }
    require('telescope').load_extension 'live_grep_args'
    local wk = require 'which-key'
    wk.register({
      g = {
        function()
          require('telescope').extensions.live_grep_args.live_grep_args()
        end,
        'live grep with args',
      },
    }, { prefix = '<leader>s' })
  end,
}
