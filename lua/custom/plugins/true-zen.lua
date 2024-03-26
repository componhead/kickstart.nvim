return {
  'Pocco81/true-zen.nvim',
  config = function()
    local sectionWidth = vim.api.nvim_win_get_width(0) * 0.65
    require('true-zen').setup {
      modes = { -- configurations per mode
        ataraxis = {
          shade = 'dark', -- if `dark` then dim the padding windows, otherwise if it's `light` it'll brighten said windows
          backdrop = 0, -- percentage by which padding windows should be dimmed/brightened. Must be a number between 0 and 1. Set to 0 to keep the same background color
          minimum_writing_area = { -- minimum size of main window
            width = 80,
            height = 100,
          },
          quit_untoggles = false, -- type :q or :qa to quit Ataraxis mode
          padding = { -- padding windows
            left = math.floor(sectionWidth / 2),
            right = math.floor(sectionWidth / 2),
            top = 1,
            bottom = 1,
          },
          callbacks = { -- run functions when opening/closing Ataraxis mode
            open_pre = nil,
            open_pos = function()
              vim.cmd.hi('WinSeparator', 'guibg="NONE"')
            end,
            close_pre = function()
              print 'closing'
            end,
            close_pos = nil,
          },
        },
        minimalist = {
          ignored_buf_types = { 'nofile' }, -- save current options from any window except ones displaying these kinds of buffers
          options = { -- options to be disabled when entering Minimalist mode
            number = false,
            relativenumber = false,
            showtabline = 0,
            signcolumn = 'no',
            statusline = '',
            cmdheight = 1,
            laststatus = 0,
            showcmd = false,
            showmode = false,
            ruler = false,
            numberwidth = 1,
          },
          callbacks = { -- run functions when opening/closing Minimalist mode
            open_pre = nil,
            open_pos = nil,
            close_pre = nil,
            close_pos = nil,
          },
        },
        narrow = {
          --- change the style of the fold lines. Set it to:
          --- `informative`: to get nice pre-baked folds
          --- `invisible`: hide them
          --- function() end: pass a custom func with your fold lines. See :h foldtext
          folds_style = 'informative',
          run_ataraxis = true, -- display narrowed text in a Ataraxis session
          callbacks = { -- run functions when opening/closing Narrow mode
            open_pre = nil,
            open_pos = nil,
            close_pre = nil,
            close_pos = nil,
          },
        },
        focus = {
          callbacks = { -- run functions when opening/closing Focus mode
            open_pre = nil,
            open_pos = nil,
            close_pre = nil,
            close_pos = nil,
          },
        },
      },
      integrations = {
        tmux = true, -- hide tmux status bar in (minimalist, ataraxis)
        kitty = { -- increment font size in Kitty. Note: you must set `allow_remote_control socket-only` and `listen_on unix:/tmp/kitty` in your personal config (ataraxis)
          enabled = false,
          font = '+3',
        },
        twilight = true, -- enable twilight (ataraxis)
        lualine = true, -- hide nvim-lualine (ataraxis)
      },
    }
    local wk = require 'which-key'
    wk.register({
      a = {
        function()
          require('true-zen').ataraxis()
        end,
        'toggle zen mode',
      },
      f = {
        function()
          require('true-zen').focus()
        end,
        'toggle focus zen mode',
      },
      m = {
        function()
          require('true-zen').minimalist()
        end,
        'toggle minimalist zen mode',
      },
    }, { prefix = '<leader>z' })
    wk.register({
      z = {
        name = '+ZENMODE',
        s = {
          function()
            require('true-zen').narrow(vim.fn.line 'v', vim.fn.line '.')
          end,
          'toggle zen mode for selection',
        },
      },
    }, { prefix = '<leader>', mode = 'x', noremap = true, silent = true, expr = true })
  end,
}
