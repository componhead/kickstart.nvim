-- Adds git related signs to the gutter, as well as utilities for managing changes NOTE: gitsigns is already included in init.lua but contains only the base
-- config. This will add also the recommended keymaps.

return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        local diffing = vim.api.nvim_create_augroup('diffing', { clear = true })
        vim.api.nvim_create_autocmd({
          'VimEnter',
          'BufEnter',
        }, {
          group = diffing,
          callback = function()
            if vim.wo.diff then
              map('n', ']x', '', { silent = true, buffer = true })
              map('n', '[x', '', { silent = true, buffer = true })
              map('n', ']]', '', { silent = true, buffer = true })
              map('n', '[[', '', { silent = true, buffer = true })
              vim.wo.scrollbind = true
              vim.wo.cursorbind = true
              vim.o.foldmethod = 'diff'
              local diffing_buffers = 0
              for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                local buffer = vim.api.nvim_win_get_buf(win)
                if vim.api.nvim_buf_is_loaded(buffer) then
                  diffing_buffers = diffing_buffers + 1
                end
              end
              if diffing_buffers > 2 then
                map('n', '][', '', { silent = true, buffer = true })
                map('n', '[]', [[<cmd>diffget //1<CR>]czz]], { silent = true, desc = 'diffget base', buffer = true })
                map('n', '[[', [[<cmd>diffget //2<CR>]czz]], { silent = true, desc = 'diffget ours', buffer = true })
                map('n', ']]', [[<cmd>diffget //3<CR>]czz]], { silent = true, desc = 'diffget theirs', buffer = true })
              else
                if diffing_buffers == 2 then
                  map('n', '[]', '', { silent = true, buffer = true })
                  map('n', ']]', '', { silent = true, buffer = true })
                  map('n', '[[', '', { silent = true, buffer = true })
                  map('n', '][', [[<cmd>diffget<CR>]czz]], { silent = true, desc = 'diffget other file', buffer = true })
                end
              end
              map('n', ']x', '<Plug>(git-conflict-next-conflict)', { silent = true, desc = 'next conflict', buffer = true })
              map('n', '[x', '<Plug>(git-conflict-prev-conflict)', { silent = true, desc = 'previuos conflict', buffer = true })
              map('n', 'xo', '<Plug>(git-conflict-ours)', { silent = true, desc = 'get ours', buffer = true })
              map('n', 'xt', '<Plug>(git-conflict-theirs)', { silent = true, desc = 'get theirs', buffer = true })
              map('n', 'xb', '<Plug>(git-conflict-both)', { silent = true, desc = 'get both', buffer = true })
              map('n', 'x0', '<Plug>(git-conflict-none)', { silent = true, desc = 'get none', buffer = true })
            else
              map({ 'n', 'v' }, '[r', gitsigns.reset_hunk, { desc = 'git reset hunk' })
              map('n', ']r', gitsigns.stage_buffer, { desc = 'git stage buffer' })
              map({ 'n', 'v' }, ']h', gitsigns.stage_hunk, { desc = 'git stage hunk(s)' })
              map({ 'n', 'v' }, '[h', gitsigns.undo_stage_hunk, { desc = 'git undo stage hunk' })
              map('n', '[R', gitsigns.reset_buffer, { desc = 'git reset buffer' })
              map('n', '[g', gitsigns.preview_hunk, { desc = 'git preview hunk' })
              map('n', ']g', gitsigns.blame_line, { desc = 'git blame line' })
              map('n', '[G', gitsigns.diffthis, { desc = 'git diff against index' })
              map('n', ']G', function()
                gitsigns.diffthis '@'
              end, { desc = 'git [D]iff against last commit' })
              -- Toggles
              map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
              map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
            end
          end,
        })
      end,
    },
  },
}
