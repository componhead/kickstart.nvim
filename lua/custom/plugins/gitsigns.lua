-- Adds git related signs to the gutter, as well as utilities for managing changes NOTE: gitsigns is already included in init.lua but contains only the base
-- config. This will add also the recommended keymaps.

return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        -- Navigation
        vim.keymap.set('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        vim.keymap.set('n', '[c', function()
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
              vim.keymap.set('n', ']x', '', { silent = true, buffer = true })
              vim.keymap.set('n', '[x', '', { silent = true, buffer = true })
              vim.keymap.set('n', ']]', '', { silent = true, buffer = true })
              vim.keymap.set('n', '[[', '', { silent = true, buffer = true })
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
                vim.keymap.set('n', '][', '', { silent = true, buffer = true })
                vim.keymap.set('n', '[]', [[<cmd>diffget //1<CR>]czz]], { silent = true, desc = 'diffget base', buffer = true })
                vim.keymap.set('n', '[[', [[<cmd>diffget //2<CR>]czz]], { silent = true, desc = 'diffget ours', buffer = true })
                vim.keymap.set('n', ']]', [[<cmd>diffget //3<CR>]czz]], { silent = true, desc = 'diffget theirs', buffer = true })
              else
                if diffing_buffers == 2 then
                  vim.keymap.set('n', '[]', '', { silent = true, buffer = true })
                  vim.keymap.set('n', ']]', '', { silent = true, buffer = true })
                  vim.keymap.set('n', '[[', '', { silent = true, buffer = true })
                  vim.keymap.set('n', '][', [[<cmd>diffget<CR>]czz]], { silent = true, desc = 'diffget other file', buffer = true })
                end
              end
              vim.keymap.set('n', ']x', '<Plug>(git-conflict-next-conflict)', { silent = true, desc = 'next conflict', buffer = true })
              vim.keymap.set('n', '[x', '<Plug>(git-conflict-prev-conflict)', { silent = true, desc = 'previuos conflict', buffer = true })
              vim.keymap.set('n', 'xo', '<Plug>(git-conflict-ours)', { silent = true, desc = 'get ours', buffer = true })
              vim.keymap.set('n', 'xt', '<Plug>(git-conflict-theirs)', { silent = true, desc = 'get theirs', buffer = true })
              vim.keymap.set('n', 'xb', '<Plug>(git-conflict-both)', { silent = true, desc = 'get both', buffer = true })
              vim.keymap.set('n', 'x0', '<Plug>(git-conflict-none)', { silent = true, desc = 'get none', buffer = true })
            else
              vim.keymap.set({ 'n', 'v' }, '[r', gitsigns.reset_hunk, { desc = 'git reset hunk' })
              vim.keymap.set('n', ']r', gitsigns.stage_buffer, { desc = 'git stage buffer' })
              vim.keymap.set({ 'n', 'v' }, ']h', gitsigns.stage_hunk, { desc = 'git stage hunk(s)' })
              vim.keymap.set({ 'n', 'v' }, '[h', gitsigns.undo_stage_hunk, { desc = 'git undo stage hunk' })
              vim.keymap.set('n', '[R', gitsigns.reset_buffer, { desc = 'git reset buffer' })
              vim.keymap.set('n', '[g', gitsigns.preview_hunk, { desc = 'git preview hunk' })
              vim.keymap.set('n', ']g', gitsigns.blame_line, { desc = 'git blame line' })
              vim.keymap.set('n', '[G', gitsigns.diffthis, { desc = 'git diff against index' })
              vim.keymap.set('n', ']G', function()
                gitsigns.diffthis '@'
              end, { desc = 'git [D]iff against last commit' })
              -- Toggles
              vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
              vim.keymap.set('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
            end
          end,
        })
      end,
    },
  },
}
