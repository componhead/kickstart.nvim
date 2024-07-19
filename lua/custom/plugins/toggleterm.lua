return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    direction = 'float',
    open_mapping = '<C-\\><C-\\>',
    -- moved to fish config
    -- on_create = function()
    --   local enter = vim.api.nvim_replace_termcodes('<CR>', true, true, true)
    --   vim.fn.feedkeys(' cd .' .. enter)
    -- end,
    on_open = function()
      vim.o.ma = true
      vim.keymap.set('n', '<UP>', '<C-\\><C-n>i<UP>', { silent = true, buffer = true })
      vim.keymap.set('n', '<DOWN>', '<C-\\><C-n>i<DOWN', { silent = true, buffer = true })
      vim.keymap.set('n', '<RIGHT>', '<C-\\><C-n>i<RIGHT>', { silent = true, buffer = true })
      vim.keymap.set('n', '<LEFT>', '<C-\\><C-n>i<LEFT>', { silent = true, buffer = true })
    end,
    autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    persist_size = true,
    persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
    close_on_exit = true, -- close the terminal window when the process exits
    shell = 'fish', -- Change the default shell. Can be a string or a function returning a string
    auto_scroll = false, -- automatically scroll to the bottom on terminal output
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
      -- The border key is *almost* the same as 'nvim_open_win'
      -- see :h nvim_open_win for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      border = 'curved',
      -- like `size`, width and height can be a number or function which is passed the current terminal
      -- winblend = 3,
      width = function(_)
        return math.floor(vim.o.columns * 0.97)
      end,
      height = function(_)
        return math.floor(vim.o.lines * 0.90)
      end,
      -- zindex = <value>,
    },
    winbar = {
      enabled = true,
      name_formatter = function(term) --  term: Terminal
        return term.name
      end,
    },
    highlights = {
      -- highlights which map to a highlight group name and a table of it's values
      -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
      -- Normal = {
      --   guibg = '#FFFFFF',
      -- },
      NormalFloat = {
        link = 'Normal',
      },
      FloatBorder = {
        guifg = '#769ff0',
        guibg = '#000000',
      },
    },
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)
    vim.keymap.set('n', '<leader>\\l', '<Cmd>TermSelect<CR>', { silent = true, desc = 'list all terminals' })
    vim.keymap.set('n', '<leader>\\t', '<Cmd>ToggleTermSetName<CR>', { silent = true, desc = 'set a name to a terminal' })
  end,
}
