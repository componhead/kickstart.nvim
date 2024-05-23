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

local md_files = vim.api.nvim_create_augroup('md-files', { clear = true })
vim.api.nvim_create_autocmd({
  'BufEnter',
}, {
  pattern = '*.md',
  group = md_files,
  callback = function()
    wk.register({
      h = {
        function()
          local command = 'NewMarkdownToHTML'
          vim.cmd(command)
        end,
        'create a html file from markdown',
        buffer = vim.api.nvim_buf_get_number(0),
      },
      H = {
        function()
          local command = 'MarkdownToHTML'
          vim.cmd(command)
        end,
        'change markdown buffer to html',
        buffer = vim.api.nvim_buf_get_number(0),
      },
      p = {
        function()
          require('md-pdf').convert_md_to_pdf()
        end,
        'transform markdown in pdf',
        buffer = vim.api.nvim_buf_get_number(0),
      },
    }, { prefix = '<leader>c' })
  end,
})

local txt_files = vim.api.nvim_create_augroup('txt-files', { clear = true })
vim.api.nvim_create_autocmd({
  'BufEnter',
}, {
  pattern = '*.txt',
  group = txt_files,
  callback = function()
    wk.register({
      h = {
        function()
          local command = 'TOhtml'
          vim.cmd(command)
        end,
        'transform markdown in html',
        buffer = vim.api.nvim_buf_get_number(0),
      },
    }, { prefix = '<leader>c' })
  end,
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
        buffer = vim.api.nvim_buf_get_number(0),
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
  'WinEnter',
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
      vim.wo.scrollbind = true
      vim.wo.cursorbind = true
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
          buffer = vim.api.nvim_buf_get_number(0),
        },
      }, { prefix = '<leader>c' })
    end

    local rust_prj = vim.fn['getcwd']() .. '/Cargo.toml'
    if vim.fn.filereadable(rust_prj) ~= 0 then
      vim.keymap.set('n', '<leader>c', function()
        vim.cmd('edit ' .. rust_prj)
      end, { desc = desc })
    end

    vim.api.nvim_command 'ColorizerAttachToBuffer'
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

local after_plugins = vim.api.nvim_create_augroup('after-plugins', { clear = true })
vim.api.nvim_create_autocmd({
  'VimEnter',
}, {
  group = after_plugins,
  callback = function()
    vim.cmd 'packadd cfilter'
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
