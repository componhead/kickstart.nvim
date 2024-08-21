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
vim.keymap.set('v', '<A-r>t', [[<Cmd>%s/\v['"](\w+)['"](:)|( Object | Array )|^\s*[+-]/\1\2/g<CR>]], { desc = 'to javascript literal object' })
vim.keymap.set('v', '<A-r>u', [[<cmd>.!uuidgen<CR>]], { expr = true, silent = true })
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
vim.keymap.set('n', '<leader>\\g', '<cmd>CdGitRoot<CR>', { desc = 'change cwd to git root' })
vim.keymap.set('n', '<leader>\\n', '<cmd>CdNodeRoot<CR>', { desc = 'change cwd to node_modules' })
vim.keymap.set('n', '<leader>\\p', '<cmd>ShowPaths<CR>', { desc = 'show paths' })
vim.keymap.set('n', '<leader>\\y', "<cmd>let @+=expand('%')<CR>", { desc = 'copy relative file path to clipboard' })
vim.keymap.set('n', '<leader>\\Y', "<cmd>let @+=expand('%:p')<CR>", { desc = 'copy absolute file path to clipboard' })
vim.keymap.set('n', '<leader>Sv', '<cmd>source $VIMRC<CR>', { desc = 'source new nvim configuration' })
vim.keymap.set('n', '<leader>tn', '<cmd>set relativenumber!<CR>', { desc = 'toggle line numbers mode' })

vim.keymap.set('c', '<C-w>', '<cmd>w !sudo tee > /dev/null %<CR>')
vim.keymap.set('c', '<C-e>', '<cmd>let @+=v:errmsg<CR><Esc>')

vim.keymap.set('i', 'jk', '<ESC>')

vim.keymap.set('t', 'jk', [[<C-\><C-n>]])
