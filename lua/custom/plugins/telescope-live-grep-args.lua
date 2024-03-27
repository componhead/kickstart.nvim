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
    local quote_prompt = {
      function()
        require('telescope-live-grep-args.actions').quote_prompt()
      end,
      "quote prompt with '",
    }
    local search_glob = {
      function()
        require('telescope-live-grep-args.actions').quote_prompt { postfix = ' --iglob ' }
      end,
      'quote and search with glob',
    }
    require('telescope').setup {
      extensions = {
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          mappings = {
            n = {
              ['<Tab>'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_worse,
              ['<S-Tab>'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_better,
              ['<C-s>'] = quote_prompt,
              ['<C-i>'] = search_glob,
            },
            i = {
              ['<Tab>'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_worse,
              ['<S-Tab>'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_better,
              ['<C-s>'] = quote_prompt,
              ['<C-i>'] = search_glob,
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
