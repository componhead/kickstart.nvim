vim.g.autocommands_loaded = true

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local diffing = vim.api.nvim_create_augroup('diffing', { clear = true })
vim.api.nvim_create_autocmd({
  'VimEnter',
  'BufEnter',
}, {
  pattern = '*',
  group = diffing,
  callback = function()
    if vim.o.diff == true then
      vim.keymap.set('n', '[[', '<cmd>diffget<cr>]czz', { desc = 'diffget (obtain)' })
      vim.keymap.set('n', ']]', '<cmd>diffput<cr>]czz', { desc = 'diffput' })
    end
  end,
})

local html_files = vim.api.nvim_create_augroup('html-files', { clear = true })
vim.api.nvim_create_autocmd({
  'BufEnter',
}, {
  pattern = '*.html,*.htm',
  group = html_files,
  callback = function()
    vim.keymap.set('n', '<leader>cb', function()
      local filename = vim.fn.expand '%:p:r'
      local open_in_browser = '!open -a "' .. vim.fn.expand '$BROWSER' .. '" "' .. filename .. '.html"'
      vim.cmd(open_in_browser)
    end, { desc = 'open file in browser' })
  end,
})

local leetcode = vim.api.nvim_create_augroup('leetcode', { clear = true })
-- leetcode plugin keybindings
vim.api.nvim_create_autocmd({
  'BufWinEnter',
}, {
  pattern = '**/.leetcode/**/*',
  group = leetcode,
  callback = function()
    vim.keymap.set('n', '<leader>clq', '<cmd>LBQuestions<cr>', { desc = 'List Questions' })
    vim.keymap.set('n', '<leader>cls', '<cmd>LBSearch<cr>', { desc = 'Search Questions' })
    vim.keymap.set('n', '<leader>clt', '<cmd>LBTest<cr>', { desc = 'Test Question' })
    vim.keymap.set('n', '<leader>clw', '<cmd>LBkrite<cr>', { desc = 'Write Question' })
    vim.keymap.set('n', '<leader>clx', '<cmd>LBDelete<cr>', { desc = 'Delete Question' })
    vim.keymap.set('n', '<leader>cly', '<cmd>LBExport<cr>', { desc = 'Export Question' })
    vim.keymap.set('n', '<leader>clz', '<cmd>LBImport<cr>', { desc = 'Import Question' })
    vim.keymap.set('n', '<leader>cl<tab>', '<cmd>LBNext<cr>', { desc = 'Next Question' })
    vim.keymap.set('n', '<leader>cl<S-tab>', '<cmd>LBPrevious<cr>', { desc = 'Previous Question' })
    vim.keymap.set('n', '<leader>cl<leader>', '<cmd>LBShow<cr>', { desc = 'Show Question' })
  end,
})

local help_pages = vim.api.nvim_create_augroup('help-pages', { clear = true })
vim.api.nvim_create_autocmd({
  'BufWinEnter',
}, {
  group = help_pages,
  callback = function()
    if vim.bo.buftype == 'help' then
      vim.cmd 'TSBufDisable highlight'
      vim.cmd 'wincmd L'
    else
      vim.cmd 'TSEnable highlight'
    end
  end,
})

local prj_files = vim.api.nvim_create_augroup('package-file', { clear = true })
vim.api.nvim_create_autocmd({
  'BufEnter',
}, {
  pattern = '*',
  group = prj_files,
  callback = function()
    local desc = 'open package management file'

    local node_prj = vim.fn['getcwd']() .. '/package.json'
    if vim.fn.filereadable(node_prj) ~= 0 then
      vim.keymap.set('n', '<leader>cp', function()
        vim.cmd('edit ' .. node_prj)
      end, { desc = desc })
    end

    local rust_prj = vim.fn['getcwd']() .. '/Cargo.toml'
    if vim.fn.filereadable(rust_prj) ~= 0 then
      vim.keymap.set('n', '<leader>c', function()
        vim.cmd('edit ' .. rust_prj)
      end, { desc = desc })
    end
  end,
})

local js_formatting = vim.api.nvim_create_augroup('js-formatting', { clear = true })
vim.api.nvim_create_autocmd({
  'BufWrite',
}, {
  pattern = '*.{js,jsx,ts}',
  group = js_formatting,
  callback = function()
    local lint_file = vim.fn['getcwd']() .. '/.eslintrc'
    if vim.fn.filereadable(lint_file) ~= 0 then
      vim.cmd 'EslintFixAll'
    end
  end,
})

local welcome = vim.api.nvim_create_augroup('welcome', { clear = true })
vim.api.nvim_create_autocmd({
  'WinEnter',
  'VimEnter'
}, {
  group = welcome,
  callback = function()
    local colors = require('tokyonight.colors').setup { transform = true }
    vim.o.number = true
    vim.o.relativenumber = true
    vim.o.cursorline = true
    vim.cmd.hi('WinSeparator', 'guibg=' .. colors.blue7)
    vim.cmd.hi('NormalNC', 'guibg=' .. colors.black)
    vim.cmd.hi('LineNr', 'guifg=' .. colors.blue2)
    vim.cmd.hi('LineNrAbove', 'guifg=' .. colors.blue0)
    vim.cmd.hi('LineNrBelow', 'guifg=' .. colors.blue0)
  end,
})
vim.api.nvim_create_autocmd({
  'WinLeave',
}, {
  group = welcome,
  callback = function()
    local colors = require('tokyonight.colors').setup { transform = true }
    vim.o.number = false
    vim.o.relativenumber = false
    vim.o.cursorline = false
    vim.cmd.hi('NormalNC', 'guibg=black')
  end,
})

