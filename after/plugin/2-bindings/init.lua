-- regex format oneline gql chrome copied curl in a new file
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
vim.keymap.set({ 'n', 'v' }, '<C-q>', 'q', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'q', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '[z', '<Cmd>mkview<CR>', { silent = true })
vim.keymap.set({ 'n', 'v' }, ']z', '<Cmd>loadview<CR>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', ']c', ']czz', { silent = true, desc = 'diffget base', buffer = true })
vim.keymap.set('n', '[c', '[czz', { silent = true, desc = 'diffget base', buffer = true })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>gp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'preview git hunk' })
vim.keymap.set('n', '<F4>', "<Cmd>echom('" .. vim.fn.expand '%:p' .. "')<CR>", { silent = true })
vim.keymap.set('n', '<C-d>', '<C-d>M')
vim.keymap.set('n', '<C-e>', '3<C-e>')
vim.keymap.set('n', '<C-u>', '<C-u>M')
vim.keymap.set('n', '<C-y>', '3<C-y>')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set({ 'n', 'v' }, '<BS>', [['_d]])
vim.keymap.set('c', '<C-w>', '<cmd>w !sudo tee > /dev/null %<CR>')
vim.keymap.set('c', '<C-y>', '<cmd>:let @+ = v:errmsg<CR><Esc>')
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

local wk = require 'which-key'
wk.register {
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = 'DEBUG', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'History', _ = 'which_key_ignore' },
  ['<leader>i'] = { name = 'IA', _ = 'which_key_ignore' },
  ['<leader>ia'] = { name = 'ASK', _ = 'which_key_ignore' },
  ['<leader>im'] = { name = 'ACT_AS', _ = 'which_key_ignore' },
  ['<leader>o'] = { name = 'ORG', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = 'REFACTORY', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}
wk.register({
  [']'] = {
    h = { '<cmd>Gitsigns stage_hunk<CR>', 'stage hunk' },
    H = { '<cmd>Gitsigns undo_stage_hunk<CR>', 'unstage hunk' },
  },
  ['['] = {
    h = { '<cmd>Gitsigns reset_hunk<CR>', 'reset hunk' },
    H = { '<cmd>Gitsigns reset buffer<CR>', 'reset buffer' },
  },
  ['<leader>'] = {
    ['\\'] = {
      name = '+FILESYSTEM',
      c = { '<cmd>CdGitRoot<CR>', 'change cwd to current git root' },
      y = { "<cmd>let @+=expand('%:p')<CR>", 'copy absolute file path to clipboard', silent = true },
      Y = { "<cmd>let @+=expand('%')<CR>", 'copy relative file path to clipboard', silent = true },
    },
    g = {
      name = '+GIT',
      b = {
        name = '+BLAME',
        b = { '<cmd>Git blame -w -C -C -C<CR>', 'real git blame' },
        l = { '<cmd>Git blame<CR>', 'last committers' },
      },
      c = { '<cmd>Telescope git_commits layout_strategy=horizontal layout_config={"width":0.9,"height":0.9}<CR>', 'commits log' },
      h = {
        function()
          require('gitsigns').diffthis('HEAD', { vertical = true, split = 'rightbelow' })
        end,
        'diff with HEAD',
        silent = true,
      },
      l = {
        name = '+LOG',
        f = {
          function()
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
          end,
          'function git log',
        },
        l = { '<cmd>Git log --oneline --decorate --graph --all<CR><C-W>L', 'git log' },
        h = {
          function()
            require('gitsigns').setqflist(0, { use_loation_list = true, open = true })
          end,
          'hunks in loclist',
        },
        r = { '<cmd>Git log -w -C -C -C<CR>', 'real file git log' },
      },
      m = {
        function()
          require('gitsigns').diffthis('origin/master', { vertical = true, split = 'rightbelow' })
        end,
        'diff with origin/master',
        silent = true,
      },
      q = {
        function()
          require('gitsigns').setqflist('all', { open = true })
        end,
        'all hunks in quickfix',
      },
      r = { '<cmd>gitsigns refresh<cr>', 'refresh' },
    },
    h = {
      name = 'History',
      c = {
        function()
          require('telescope.builtin').command_history()
        end,
        'history of commands',
        silent = true,
      },
      q = {
        function()
          require('telescope.builtin').quickfixhistory()
        end,
        'history of quickfix',
        silent = true,
      },
      r = {
        function()
          require('telescope').extensions.neoclip.default()
        end,
        'history of registers',
        silent = true,
      },
      s = {
        function()
          require('telescope.builtin').search_history()
        end,
        'history of searches',
        silent = true,
      },
    },
    M = { '<cmd>Telescope marks <CR>', 'open marks' },
    Q = {
      name = '+QUICKFIX',
      Q = { '<cmd>Telescope quickfix<CR>', 'open quickfix' },
    },
    S = {
      name = '+SESSION',
      v = { '<cmd>source $VIMRC<CR>', 'source new nvim configuration' },
      S = { '<cmd>SessionManager<CR>', 'session manager' },
    },
  },
}, {
  mode = 'n',
  noremap = true,
  silent = true,
  expr = false,
})

wk.register({
  ['<leader>i'] = { name = 'IA', _ = 'which_key_ignore' },
  ['<leader>ic'] = { name = 'COMPLETE', _ = 'which_key_ignore' },
  ['<leader>ie'] = { name = 'EDIT_WITH_INSTRUCTIONS', _ = 'which_key_ignore' },
}, { mode = 'x', noremap = true, silent = true, expr = true })
wk.register({
  ['<leader>'] = {
    g = {
      name = '+GIT',
      b = {
        function()
          local esc = vim.api.nvim_replace_termcodes('<esc>', true, false, true)
          local ret = vim.api.nvim_replace_termcodes('<CR>', true, false, true)
          vim.api.nvim_feedkeys(esc, 'x', false)
          local start_line = vim.api.nvim_buf_get_mark(0, '<')[1]
          local end_line = vim.api.nvim_buf_get_mark(0, '>')[1]
          local command = ':Git blame -w -C -C -C -L ' .. start_line .. ',' .. end_line .. ' %' .. ret
          vim.api.nvim_feedkeys(command, 't', true)
        end,
        'real chunk git blame',
      },
      l = {
        function()
          local esc = vim.api.nvim_replace_termcodes('<esc>', true, false, true)
          local ret = vim.api.nvim_replace_termcodes('<CR>', true, false, true)
          vim.api.nvim_feedkeys(esc, 'x', false)
          local start_line = vim.api.nvim_buf_get_mark(0, '<')[1]
          local end_line = vim.api.nvim_buf_get_mark(0, '>')[1]
          local command = ':Git log -w -C -C -C -L ' .. start_line .. ',' .. end_line .. ':%' .. ret
          vim.api.nvim_feedkeys(command, 't', true)
        end,
        'real chunk git log',
      },
      L = { '<cmd>Gclog<CR>', 'commit log in qf for selected chunk' },
    },
  },
}, { mode = 'v', noremap = true, silent = true, expr = true })
