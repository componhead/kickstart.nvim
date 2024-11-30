local wk = require('which-key')
-- regex format oneline gql chrome copied curl in a new gile
wk.add({
  mode = 'v',
  {
    '<A-r>g',
    [[<Cmd>s/\v"(})' \\|([[{]|[]}]|[]}]|.}@=|\w\\u\d{4},?|,\W@<=)|\W}@=|.@<=\\\\n\s*|\\u0021|--data-raw [$']*|"query":"/\1\2\r/g<CR>yu<Cmd>vsplit formatted.gql<CR>p<Cmd>%s/\\u0021/!/g<CR><Cmd>%g/^\s*$/d<CR><Cmd>nohlsearch<CR>gg=G]],
    desc = 'curl gql format to json format'
  },
  {'<A-r>j', [[<Cmd>s/\v^'(.*)'$/\1/g<CR>yu<Cmd>vsplit formatted.json<CR>p<Cmd>nohlsearch<CR>gg=G]], desc = 'to json format' },
  {'<A-r>s', [[<Cmd>s/\v^(\s*[a-z]{-})([A-Z]{1})/\1_\u\2/g<CR>]], desc = 'camelCase to snake_case' },
  {'<A-r>c', [[<Cmd>s/\v^(\s*[a-z]{-})_([a-z]{1})/\1\U\2/g<CR>]], desc = 'snake_case to camelCase' },
  {'<A-r>t', [[<Cmd>%s/\v['"](\w+)['"](:)|( Object | Array )|^\s*[+-]/\1\2/g<CR>]], desc = 'to javascript literal object' },
  {'<A-r>u', [[<cmd>.!uuidgen<CR>]], desc = 'generate uuid' },
})
vim.keymap.set('v', '<C-c>', [["+y]])

vim.keymap.set({ 'n', 'v' }, '<BS>', [["_d]])

-- [[ Custom Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'i' }, '<C-S-o>', '<cmd>bprev<CR>', { silent = true })
vim.keymap.set({ 'n', 'i' }, '<C-S-i>', '<cmd>bnext<CR>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', '<C-d>', '<C-d>M')
vim.keymap.set('n', '<C-e>', '3<C-e>')
vim.keymap.set('n', '<C-u>', '<C-u>M')
vim.keymap.set('n', '<C-y>', '3<C-y>')

vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', '<leader>\\c', function()
  local root = vim.g.session_file_path or Get_root '.git'
  vim.fn.setreg('+', root)
end, { desc = 'copy git root path to clipboard' })
vim.keymap.set('n', '<leader>\\g', function() vim.cmd'CdGitRoot' end, { desc = 'change cwd to git root' })
vim.keymap.set('n', '<leader>\\n', function() vim.cmd'CdNodeRoot' end, { desc = 'change cwd to node_modules' })
vim.keymap.set('n', '<leader>\\p', function() vim.cmd'ShowPaths' end, { desc = 'show paths' })
vim.keymap.set('n', '<leader>\\w', function() vim.cmd'CdWindowGitRoot' end, { desc = 'change cwd to window git root' })
vim.keymap.set('n', '<leader>\\y', function() vim.cmd"let @+=expand('%')" end, { desc = 'copy relative file path to clipboard' })
vim.keymap.set('n', '<leader>\\Y', function() vim.cmd"let @+=expand('%:p')" end, { desc = 'copy absolute file path to clipboard' })
vim.keymap.set('n', '<leader>Sv', function() vim.cmd'source $VIMRC' end, { desc = 'source new nvim configuration' })
vim.keymap.set('n', '<leader>tn', function() vim.cmd'set relativenumber!' end, { desc = 'toggle line numbers mode' })
vim.keymap.set('n', '<leader>ts', function() vim.cmd'set scrollbind!' end, { desc = 'toggle scrollbind mode' })
vim.keymap.set('n', '<leader>t/', function()
  if(vim.o.hls == true) then
    vim.o.hls = false
  else
    vim.o.hls = true
  end
end, { desc = 'Toggle search highlight' })

vim.keymap.set('c', '<C-w>', '<cmd>w !sudo tee > /dev/null %<CR>')
vim.keymap.set('c', '<C-e>', '<cmd>let @+=v:errmsg<CR><Esc>')
