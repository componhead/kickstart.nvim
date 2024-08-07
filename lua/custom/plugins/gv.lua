return {
  'junegunn/gv.vim',
  dependencies = { 'tpope/vim-fugitive' },
  version = '*',
  config = function()
    vim.keymap.set('n', '<leader>gbb', '<cmd>Git blame -w -C -C -C<CR>', { desc = 'real git blame' })
    vim.keymap.set('n', '<leader>gbl', '<cmd>Git blame<CR>', { desc = 'last committers' })
    vim.keymap.set('n', '<leader>gll', '<cmd>Git log --oneline --decorate --graph --all<CR><C-W>L', { desc = 'git log' })
    vim.keymap.set('n', '<leader>glr', '<cmd>Git log -w -C -C -C<CR>', { desc = 'real git log' })

    vim.keymap.set('n', '<leader>glp', function()
      local command = ':Git log -p -S'
      vim.api.nvim_feedkeys(command, 't', true)
    end, { desc = 'pickaxe' })

    vim.keymap.set('n', '<leader>gc', function()
      function get_current_function()
        -- TODO: remove
        local ts_utils = require 'nvim-treesitter.ts_utils'
        local M = {}

        function M.get_current_function_name()
          -- TODO: use vim.treesitter.get_node()
          local current_node = ts_utils.get_node_at_cursor()
          if not current_node then
            return ''
          end

          local expr = current_node

          while expr do
            if expr:type() == 'function_definition' then
              break
            end
            expr = expr:parent()
          end

          if not expr then
            return ''
          end

          -- TODO: use vim.treesitter.query.get_node_text()
          return (ts_utils.get_node_text(expr:child(1)))[1]
        end

        return M
      end

      local fn_name = get_current_function().get_current_function_name()
      if fn_name ~= '()' then
        fn_name = ':' .. fn_name .. ':%'
        local command = 'Git log -w -C -C -C -L ' .. fn_name
        vim.cmd(command)
      else
        local command = ':Git log -w -C -C -C -L :_fname_:%'
        vim.api.nvim_feedkeys(command, 't', true)
      end
    end, { desc = 'function git log' })

    vim.keymap.set('v', '<leader>gb', function()
      local esc = vim.api.nvim_replace_termcodes('<esc>', true, false, true)
      local ret = vim.api.nvim_replace_termcodes('<CR>', true, false, true)
      vim.api.nvim_feedkeys(esc, 'x', false)
      local start_line = vim.api.nvim_buf_get_mark(0, '<')[1]
      local end_line = vim.api.nvim_buf_get_mark(0, '>')[1]
      local command = ':Git blame -w -C -C -C -L ' .. start_line .. ',' .. end_line .. ' %' .. ret
      vim.api.nvim_feedkeys(command, 't', true)
    end, { desc = 'real chunk git blame' })

    vim.keymap.set('v', '<leader>gl', function()
      local esc = vim.api.nvim_replace_termcodes('<esc>', true, false, true)
      local ret = vim.api.nvim_replace_termcodes('<CR>', true, false, true)
      vim.api.nvim_feedkeys(esc, 'x', false)
      local start_line = vim.api.nvim_buf_get_mark(0, '<')[1]
      local end_line = vim.api.nvim_buf_get_mark(0, '>')[1]
      local command = ':Git log -w -C -C -C -L ' .. start_line .. ',' .. end_line .. ':%' .. ret
      vim.api.nvim_feedkeys(command, 't', true)
    end, { desc = 'real chunk git log' })

    vim.keymap.set('v', '<leader>gL', '<cmd>Gclog<CR>', { desc = 'commit log in qf for selected chunk' })

    vim.keymap.set('c', '<C-g>', 'Gvdiffsplit HEAD...origin/master<CR>', { silent = false })
  end,
}
