return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    { 'kkharji/sqlite.lua' },
    { 'sharkdp/fd' },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    local select_one_or_multi = function(bufnr)
      local rows = require('telescope.actions.state').get_current_picker(bufnr):get_multi_selection()
      if not vim.tbl_isempty(rows) then
        require('telescope.actions').close(bufnr)
        for _, j in pairs(rows) do
          if j.path ~= nil then
            vim.cmd(string.format('%s %s', 'edit', j.path))
          end
        end
      else
        require('telescope.actions').select_default(bufnr)
      end
    end

    local remove_selected_from_qf = function(bufnr)
      local list = vim.fn.getqflist()
      local rows = require('telescope.actions.state').get_current_picker(bufnr):get_multi_selection()
      if vim.tbl_isempty(rows) then
        rows = { require('telescope.actions.state').get_selected_entry() }
      end
      for _, row in pairs(rows) do
        for idx, item in pairs(list) do
          if item.bufnr == row.bufnr and item.text == row.text and item.lnum == row.lnum  and item.col == row.col then
            table.remove(list, idx)
            idx = idx - 1
          end
        end
      end
      vim.fn.setqflist(list)
      vim.cmd('Telescope quickfix')
    end

    local grep_on_qf = function(bufnr)
      require('telescope.actions').smart_send_to_qflist(bufnr)
      local list = vim.fn.getqflist()
      if vim.tbl_isempty(list) then
        vim.notify('No items to grep into', vim.log.levels.WARN)
        require('telescope.builtin').live_grep { prompt_title = 'Live Grep' }
      else
        local paths = Get_list_paths(list)
        require('telescope.builtin').live_grep { prompt_title = 'Live Grep on Quickfix files', search_dirs = paths }
      end
    end

    local send_selected_to_qf = function(bufnr)
      local rows = require('telescope.actions.state').get_current_picker(bufnr):get_multi_selection()
      if vim.tbl_isempty(rows) then
        rows = { require('telescope.actions').toggle_all(bufnr) }
      end
      require('telescope.actions').smart_send_to_qflist(bufnr, rows)
      vim.cmd('Telescope quickfix')
    end

    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      defaults = {
        -- https://github.com/nvim-telescope/telescope.nvim/blob/c2b8311dfacd08b3056b8f0249025d633a4e71a8/lua/telescope/mappings.lua#L133
        mappings = {
          n = {
            ['<C-v>'] = require('telescope.actions').select_vertical,
            ['<C-h>'] = require('telescope.actions').select_horizontal,
            ['<C-t>'] = require('telescope.actions').select_tab,
            ['<C-a>'] = require('telescope.actions').toggle_all,
            ['<C-b>'] = require('telescope.actions').results_scrolling_up,
            ['<C-f>'] = require('telescope.actions').results_scrolling_down,
            ['<S-Down>'] = require('telescope.actions').cycle_history_next,
            ['<S-Up>'] = require('telescope.actions').cycle_history_prev,
            ['<PageDown>'] = false,
            ['<PageUp>'] = false,
            ['<CR>'] = select_one_or_multi,
          },
          i = {
            ['<C-v>'] = require('telescope.actions').select_vertical,
            ['<C-h>'] = require('telescope.actions').select_horizontal,
            ['<C-t>'] = require('telescope.actions').select_tab,
            ['<C-a>'] = require('telescope.actions').toggle_all,
            ['<C-b>'] = require('telescope.actions').results_scrolling_up,
            ['<C-f>'] = require('telescope.actions').results_scrolling_down,
            ['<S-Down>'] = require('telescope.actions').cycle_history_next,
            ['<S-Up>'] = require('telescope.actions').cycle_history_prev,
            ['<PageDown>'] = false,
            ['<PageUp>'] = false,
            ['<CR>'] = select_one_or_multi,
          },
        },
        preview = {
          hide_on_startup = false,
        },
        dynamic_preview_title = true,
        scroll_strategy = 'limit',
        path_display = {
          shorten = { len = 4, exclude = { -2, -1 } },
          truncate = 3,
        },
        layout_strategy = 'flex',
        layout_config = {
          mirror = false,
          prompt_position = 'top',
          width = 0.75,
          height = 0.9,
          horizontal = {
            preview_width = 0.5,
          },
          vertical = {
            preview_height = 0.5,
          },
        },
        sorting_strategy = 'ascending',
      },
      pickers = {
        buffers = {
          sort_mru = true,
          ignore_current_buffer = true,
          mappings = {
            n = {
              d = require('telescope.actions').delete_buffer,
            },
            i = {
              ['<C-S-d>'] = require('telescope.actions').delete_buffer,
            },
          },
        },
        live_grep = {
          mappings = {
            n = {
              ['<C-g>'] = {
                grep_on_qf,
                type = 'action',
                opts = {
                  nowait = true,
                  silent = false,
                  desc = 'Live grep on found files results',
                },
              },
              ['<C-q>'] = {
                send_selected_to_qf,
                type = 'action',
                opts = {
                  nowait = true,
                  silent = false,
                  desc = 'Send selected to quickfix list',
                },
              },
            },
            i = {
              ['<C-g>'] = {
                grep_on_qf,
                type = 'action',
                opts = {
                  nowait = true,
                  silent = false,
                  desc = 'Live grep on found files results',
                },
              },
              ['<C-q>'] = {
                send_selected_to_qf,
                type = 'action',
                opts = {
                  nowait = true,
                  silent = false,
                  desc = 'Send selected to quickfix list',
                },
              },
            },
          },
        },
        find_files = {
          mappings = {
            n = {
              ['<C-g>'] = {
                grep_on_qf,
                type = 'action',
                opts = {
                  nowait = true,
                  silent = false,
                  desc = 'Live grep on found files results',
                },
              },
              ['<C-q>'] = {
                send_selected_to_qf,
                type = 'action',
                opts = {
                  nowait = true,
                  silent = false,
                  desc = 'Send selected to quickfix list',
                },
              },
            },
            i = {
              ['<C-g>'] = {
                grep_on_qf,
                type = 'action',
                opts = {
                  nowait = true,
                  silent = false,
                  desc = 'Live grep on found files results',
                },
              },
              ['<C-q>'] = {
                send_selected_to_qf,
                type = 'action',
                opts = {
                  nowait = true,
                  silent = false,
                  desc = 'Send selected to quickfix list',
                },
              },
            },
          },
        },
        quickfix = {
          show_line = false,
          trim_text = true,
          mappings = {
            n = {
              ['<C-g>'] = {
                grep_on_qf,
                type = 'action',
                opts = {
                  nowait = true,
                  silent = false,
                  desc = 'Live grep on found files results',
                },
              },
              ['<C-q>'] = {
                send_selected_to_qf,
                type = 'action',
                opts = {
                  nowait = true,
                  silent = false,
                  desc = 'Send selected to quickfix list',
                },
              },
              d = {
                remove_selected_from_qf,
                type = 'action',
                opts = {
                  nowait = true,
                  silent = true,
                  desc = 'Remove entry from quickfix list',
                },
              },
            },
            i = {
              ['<C-g>'] = {
                grep_on_qf,
                type = 'action',
                opts = {
                  nowait = true,
                  silent = false,
                  desc = 'Live grep on found files results',
                },
              },
              ['<C-q>'] = {
                send_selected_to_qf,
                type = 'action',
                opts = {
                  nowait = true,
                  silent = false,
                  desc = 'Send selected to quickfix list',
                },
              },
              ['<C-S-d>'] = {
                remove_selected_from_qf,
                type = 'action',
                opts = {
                  nowait = true,
                  silent = true,
                  desc = 'Remove entry from quickfix list',
                },
              },
            },
          },
        },
        diagnostics = {
          layout_strategy = 'vertical',
          layout_config = {
            mirror = true,
            prompt_position = 'top',
            width = 0.9,
            height = 0.9,
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        persisted = {
          layout_config = { width = 0.33, height = 0.50 },
        }
      }
    }

    vim.keymap.set(
      'n',
      '<leader>glf',
      function()
        vim.cmd'Telescope git_commits layout_strategy=horizontal layout_config={"width":0.9,"height":0.9}'
      end,
      { desc = 'commits log' }
    )

    vim.keymap.set('n', '<leader>hc', function() require('telescope.builtin').command_history() end, { desc = 'history of commands' })

    vim.keymap.set('n', '<leader>hq', function() require('telescope.builtin').quickfixhistory() end, { desc = 'history of quickfix' })

    vim.keymap.set('n', '<leader>hs', function() require('telescope.builtin').search_history() end, { desc = 'history of searches' })

    vim.keymap.set('n', '<leader>hn', function() require('telescope.builtin').notify() end, { desc = 'history of notify' })

    vim.keymap.set('n', '<leader>qq', function() vim.cmd'Telescope quickfix' end, { desc = 'open quickfix' })

    vim.keymap.set('n', '<leader>sc', function() require('telescope.builtin').find_files { cwd = require('telescope.utils').buffer_dir() } end, { desc = "search files under file's directories" })

    vim.keymap.set('n', '<leader>sp', function() require('telescope.builtin').live_grep { cwd = require('telescope.utils').buffer_dir() } end, { desc = "grep text under file's directories" })

    vim.keymap.set('n', '<leader>sz', function() require('telescope.builtin').current_buffer_fuzzy_find() end, { desc = 'fuzzy search in current buffer' })

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'neoclip')
    pcall(require("telescope").load_extension, 'persisted')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader><leader><leader>', function()
      local cwd = vim.fn.getcwd()
      local result = {}
      for value in pairs(vim.cmd('buffers')) do
        print(value.flag)
        if value:match(cwd) == nil then
          table.insert(result, value) 
        end
      end
      return result
    end, { desc = 'find external existing buffers' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader>1', function()
      builtin.buffers { cwd = '' .. Get_root '.git' .. '/src/', prompt_title = 'Find sources buffers' }
    end, { desc = 'Find src buffers' })
    vim.keymap.set('n', '<leader>2', function()
      builtin.buffers { cwd = '' .. Get_root '.git' .. '/test/', prompt_title = 'Find tests buffers' }
    end, { desc = 'Find tests buffers' })
    vim.keymap.set('n', '<leader><leader>', function()
      builtin.buffers { only_cwd = true }
    end, { desc = '[ ] Find existing buffers in cwd' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', 's/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', 'sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
