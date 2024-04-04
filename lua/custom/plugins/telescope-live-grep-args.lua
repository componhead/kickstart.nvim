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
            n = {
              ['<Tab>'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_worse,
              ['<S-Tab>'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_better,
            },
            i = {
              ['<Tab>'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_worse,
              ['<S-Tab>'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_better,
              ['<C-s>'] = require('telescope-live-grep-args.actions').quote_prompt { postfix = ' ' },
              ['<C-i>'] = require('telescope-live-grep-args.actions').quote_prompt { postfix = ' --iglob ' },
              ['<C-g>'] = {
                function(p_bufnr)
                  -- send results to quick fix list
                  require('telescope.actions').send_to_qflist(p_bufnr)
                  local qflist = vim.fn.getqflist()
                  local paths = {}
                  local hash = {}
                  for k in pairs(qflist) do
                    local path = vim.fn.bufname(qflist[k]['bufnr']) -- extract path from quick fix list
                    if not hash[path] then -- add to paths table, if not already appeared
                      paths[#paths + 1] = path
                      hash[path] = true -- remember existing paths
                    end
                  end
                  -- show search scope with message
                  vim.notify('find in ...\n  ' .. table.concat(paths, '\n  '))
                  -- execute live_grep_args with search scope
                  require('telescope').extensions.live_grep_args.live_grep_args { search_dirs = paths }
                end,
                type = 'action',
                opts = {
                  nowait = true,
                  silent = true,
                  desc = 'Live grep on results',
                },
              },
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
