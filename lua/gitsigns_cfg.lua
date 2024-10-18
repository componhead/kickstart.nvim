return { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    config = function()
      local gitsigns = require 'gitsigns'
      gitsigns.setup {
        on_attach = function(bufnr)
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal { ']czz', bang = true }
            else
              gitsigns.nav_hunk 'next'
            end
          end, { desc = 'Jump to next git [c]hange' })

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal { '[czz', bang = true }
            else
              gitsigns.nav_hunk 'prev'
            end
          end, { desc = 'Jump to previous git [c]hange' })

          -- Actions
          map({ 'n', 'v' }, '<leader>g+', gitsigns.stage_hunk, { desc = 'git stage hunk' })
          map({ 'n', 'v' }, '<leader>g-', gitsigns.undo_stage_hunk, { desc = 'git undo stage hunk' })
          map({ 'n', 'v' }, '<leader>gr', gitsigns.reset_hunk, { desc = 'git reset hunk' })
          map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'git reset buffer' })
          map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'git stage buffer' })
          map('n', '<leader>gP', gitsigns.preview_hunk, { desc = 'git preview hunk' })
          map('n', '<leader>gtw', gitsigns.toggle_word_diff, { desc = 'toggle git word diff' })
          map('n', '<leader>gtl', gitsigns.toggle_linehl, { desc = 'toggle git line highlights' })
          map('n', '<leader>gb', '<cmd>Gitsigns blame<cr>', { desc = 'git show blame' })
          map('n', '<leader>gtb', '<cmd>Gitsigns toggle_current_line_blame<cr>', { desc = 'toggle git line blame' })
        end,
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        signs_staged = {
          add = { text = '┃' },
          change = { text = '┃' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
          untracked = { text = '┆' },
        },
        signs_staged_enable = true,
        signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
        numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          follow_files = true,
        },
        auto_attach = true,
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1,
        },
      }
      local gitsigns_plugin = vim.api.nvim_create_augroup('gitsigns-plugin', { clear = true })
      vim.api.nvim_create_autocmd({
        'WinLeave',
      }, {
        group = gitsigns_plugin,
        pattern = '*',
        callback = function()
          vim.cmd 'Gitsigns detach'
        end,
      })
      vim.api.nvim_create_autocmd({
        'WinEnter',
      }, {
        group = gitsigns_plugin,
        pattern = '*',
        callback = function()
          vim.cmd 'Gitsigns attach'
        end,
      })
    end,
  }
