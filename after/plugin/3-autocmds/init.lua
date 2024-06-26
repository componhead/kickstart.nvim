vim.g.autocommands_loaded = true
local wk = require 'which-key'

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local html_files = vim.api.nvim_create_augroup('html-files', { clear = true })
vim.api.nvim_create_autocmd({
  'BufEnter',
}, {
  pattern = '*.html,*.htm',
  group = html_files,
  callback = function()
    wk.register({
      b = {
        function()
          local command = '!open -a "' .. vim.fn.expand '$BROWSER' .. '" "' .. vim.fn.expand '%:p' .. '"'
          vim.cmd(command)
        end,
        'open file in browser',
        buffer = vim.api.nvim_get_current_buf(),
      },
    }, { prefix = '<leader>c' })
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
    local wk = require 'which-key'
    wk.register({
      l = {
        name = '+LEETBUDDY',
        q = { '<cmd>LBQuestions<cr>', 'List Questions' },
        s = { '<cmd>LBSearch<cr>', 'Search Questions' },
        t = { '<cmd>LBTest<cr>', 'Test Question' },
        w = { '<cmd>LBkrite<cr>', 'Write Question' },
        x = { '<cmd>LBDelete<cr>', 'Delete Question' },
        y = { '<cmd>LBExport<cr>', 'Export Question' },
        z = { '<cmd>LBImport<cr>', 'Import Question' },
        ['<tab>'] = { '<cmd>LBNext<cr>', 'Next Question' },
        ['<S-tab>'] = { '<cmd>LBPrevious<cr>', 'Previous Question' },
        ['<leader>'] = { '<cmd>LBShow<cr>', 'Show Question' },
      },
    }, { prefix = '<leader>c' })
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
    local wk = require 'which-key'

    local node_prj = vim.fn['getcwd']() .. '/package.json'
    if vim.fn.filereadable(node_prj) ~= 0 then
      wk.register({
        p = {
          function()
            vim.cmd('edit ' .. node_prj)
          end,
          desc,
          buffer = vim.api.nvim_get_current_buf(),
        },
      }, { prefix = '<leader>c' })
    end

    local rust_prj = vim.fn['getcwd']() .. '/Cargo.toml'
    if vim.fn.filereadable(rust_prj) ~= 0 then
      vim.keymap.set('n', '<leader>c', function()
        vim.cmd('edit ' .. rust_prj)
      end, { desc = desc })
    end
  end,
})

local nvim_session_group = vim.api.nvim_create_augroup('nvim-session-group', { clear = true })
-- Auto save session
vim.api.nvim_create_autocmd({
  'BufWritePre',
}, {
  group = nvim_session_group,
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      -- Don't save while there's any 'nofile' buffer open.
      if vim.api.nvim_get_option_value('buftype', { buf = buf }) == 'nofile' then
        return
      end
    end
    require('session_manager').autosave_session()
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
  'BufEnter',
}, {
  group = welcome,
  callback = function()
    local colors = require('tokyonight.colors').setup { transform = true }
    vim.o.number = true
    vim.o.relativenumber = true
    vim.o.cursorline = true
    vim.cmd.hi('WinSeparator', 'guibg=' .. colors.blue7)
    vim.cmd.hi('NormalNC', 'guibg=' .. colors.black)
    vim.cmd.hi('LineNr', 'guifg=' .. colors.blue0, 'guibg=NONE', 'cterm=NONE', 'gui=NONE')
  end,
})
vim.api.nvim_create_autocmd({
  'WinLeave',
}, {
  group = welcome,
  callback = function()
    vim.o.number = false
    vim.o.relativenumber = false
    vim.o.cursorline = false
  end,
})

local leave = vim.api.nvim_create_augroup('leave', { clear = true })
vim.api.nvim_create_autocmd({
  'VimLeave',
  'VimSuspend',
}, {
  group = leave,
  callback = function()
    local cwd = vim.fn.getcwd()
    vim.cmd('let @+="' .. cwd .. '"')
  end,
})
