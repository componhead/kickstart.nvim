-- regex format oneline gql chrome copied curl in a new gile
vim.keymap.set(
  'v',
  '<A-r>g',
  [[<Cmd>s/\v"(})' \\|([[{]|[]}]|[]}]|.}@=|\w\\u\d{4},?|,\W@<=)|\W}@=|.@<=\\\\n\s*|\\u0021|--data-raw [$']*|"query":"/\1\2\r/g<CR>yu<Cmd>vsplit formatted.gql<CR>p<Cmd>%s/\\u0021/!/g<CR><Cmd>%g/^\s*$/d<CR><Cmd>nohlsearch<CR>gg=G]],
  { desc = 'curl gql format to json format' }
)
vim.keymap.set('v', '<A-r>j', [[<Cmd>s/\v^'(.*)'$/\1/g<CR>yu<Cmd>vsplit formatted.json<CR>p<Cmd>nohlsearch<CR>gg=G]], { desc = 'to json format' })
vim.keymap.set('v', '<A-r>s', [[<Cmd>s/\v^(\s*[a-z]{-})([A-Z]{1})/\1_\u\2/g<CR>]], { desc = 'camelCase to snake_case' })
vim.keymap.set('v', '<A-r>c', [[<Cmd>s/\v^(\s*[a-z]{-})_([a-z]{1})/\1\U\2/g<CR>]], { desc = 'snake_case to camelCase' })
vim.keymap.set('v', '<A-r>t', [[<Cmd>%s/\v['"](\w+)['"](:)|( Object | Array )|^\s*[+-]/\1\2/g<CR>]], { desc = 'from stringified to javascript literal object' })

vim.keymap.set('v', 'y', [["+y]])

-- [[ Custom Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set('c', '<C-g>', 'Gvdiffsplit')
vim.keymap.set({ 'n', 'i' }, '<C-S-o>', '<cmd>bprev<CR>', { silent = true })
vim.keymap.set({ 'n', 'i' }, '<C-S-i>', '<cmd>bnext<CR>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', '<C-d>', '<C-d>M')
vim.keymap.set('n', '<C-e>', '3<C-e>')
vim.keymap.set('n', '<C-u>', '<C-u>M')
vim.keymap.set('n', '<C-y>', '3<C-y>')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('c', '<C-w>', '<cmd>w !sudo tee > /dev/null %<CR>')
vim.keymap.set('c', '<C-y>', '<cmd>let @+=v:errmsg<CR><Esc>')
vim.keymap.set('i', 'jk', '<ESC>')
vim.keymap.set('t', 'jk', [[<C-\><C-n>]])
vim.keymap.set('n', '<leader>sc', function()
  require('telescope.builtin').find_files { cwd = require('telescope.utils').buffer_dir() }
end, { desc = "search files under file's directories" })
vim.keymap.set('n', '<leader>sp', function()
  require('telescope.builtin').live_grep { cwd = require('telescope.utils').buffer_dir() }
end, { desc = "grep text under file's directories" })
vim.keymap.set('n', '<leader>sz', function()
  require('telescope.builtin').current_buffer_fuzzy_find()
end, { desc = 'fuzzy search in current buffer' })

vim.keymap.set('n', '<leader>\\y', "<cmd>let @+=expand('%')<CR>", { desc = 'copy relative file path to clipboard' })
vim.keymap.set('n', '<leader>\\Y', "<cmd>let @+=expand('%:p')<CR>", { desc = 'copy absolute file path to clipboard' })
vim.keymap.set('n', '<leader>gbb', '<cmd>Git blame -w -C -C -C<CR>', { desc = 'real git blame' })
vim.keymap.set('n', '<leader>gbl', '<cmd>Git blame<CR>', { desc = 'last committers' })
vim.keymap.set(
  'n',
  '<leader>glf',
  '<cmd>Telescope git_commits layout_strategy=horizontal layout_config={"width":0.9,"height":0.9}<CR>',
  { desc = 'commits log' }
)
vim.keymap.set('n', '<leader>gll', '<cmd>Git log --oneline --decorate --graph --all<CR><C-W>L', { desc = 'git log' })
vim.keymap.set('n', '<leader>glr', '<cmd>Git log -w -C -C -C<CR>', { desc = 'real git log' })
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
vim.keymap.set('n', '<leader>hc', function()
  require('telescope.builtin').command_history()
end, { desc = 'history of commands' })
vim.keymap.set('n', '<leader>hq', function()
  require('telescope.builtin').quickfixhistory()
end, { desc = 'history of quickfix' })
vim.keymap.set('n', '<leader>hr', function()
  require('telescope').extensions.neoclip.default()
end, { desc = 'history of registers' })
vim.keymap.set('n', '<leader>hs', function()
  require('telescope.builtin').search_history()
end, { desc = 'history of searches' })
vim.keymap.set('n', '<leader>qq', '<cmd>Telescope quickfix<CR>', { desc = 'open quickfix' })
vim.keymap.set('n', '<leader>Sv', '<cmd>source $VIMRC<CR>', { desc = 'source new nvim configuration' })
vim.keymap.set('n', '<leader>SS', '<cmd>SessionManager<CR>', { desc = 'session manager' })
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
