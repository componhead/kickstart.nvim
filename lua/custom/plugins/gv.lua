return {
  'junegunn/gv.vim',
  dependencies = { 'tpope/vim-fugitive' },
  version = '*',
  config = function()
    vim.keymap.set('n', '<leader>gbb', function() vim.cmd'Git blame -w -C -C -C' end, { desc = 'real git blame' })
    vim.keymap.set('n', '<leader>gbl', function() vim.cmd'Git blame' end, { desc = 'last committers' })
    vim.keymap.set('n', '<leader>gll', function() vim.cmd'GV' end, { desc = 'git log' })
    vim.keymap.set('n', '<leader>glr', function() vim.cmd'GV -w -C -C -C' end, { desc = 'real git log' })

    vim.keymap.set('n', '<leader>glp', function()
      local command = ':GV -p -S'
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
        local command = 'GV -w -C -C -C -L ' .. fn_name
        vim.cmd(command)
      else
        local command = ':GV -w -C -C -C -L :_fname_:%'
        vim.api.nvim_feedkeys(command, 't', true)
      end
    end, { desc = 'git log' })

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
      local command = ':GV -w -C -C -C -L ' .. start_line .. ',' .. end_line .. ':%' .. ret
      vim.api.nvim_feedkeys(command, 't', true)
    end, { desc = 'real chunk git log' })

    vim.keymap.set('v', '<leader>gL', '<cmd>Gclog<CR>', { desc = 'commit log in qf for selected chunk' })

    vim.keymap.set('n', '<leader>go', [[<cmd>Gvdiffsplit HEAD...origin/master | wincmd h<CR>]], { desc = 'compare with origin/master' })
    vim.keymap.set('n', '<leader>g@', [[<cmd>Gvdiffsplit HEAD@{1} | wincmd h<CR>]], { desc = 'git diff against last commit' })
  end,
}
