return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    function codeiumStatus()
      if vim.fn.mode() ~= 'i' then
        return ''
      else
        return vim.fn['codeium#GetStatusString']()
      end
    end

    function checkCwd()
      local cwd = vim.fn.getcwd()
      local filename = vim.fn.expand '%:p'
      if filename:find(cwd) == nil then
        return '❗'
      end
    end

    local colors = require('tokyonight.colors').setup { transform = true }
    require('lualine').setup {
      options = {
        -- disabled_filetypes = {
        --   statusline = {},
        --   winbar = {},
        -- },
        disabled_filetypes = { 'neo-tree', 'neo-tree-popup', 'notify' },
        icons_enabled = true,
        theme = 'tokyonight',

        section_separators = { left = '', right = '' },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          'branch',
          -- 'diff',
          'string.gsub(vim.fn.getcwd(), vim.env.HOME, "~")',
        },
        lualine_c = {
          {
            'filename',
            file_status = true, -- Displays file status (readonly status, modified status)
            newfile_status = true, -- Display new file status (new file means no write after created)
            path = 4, -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory
            -- 4: Filename and parent dir, with tilde as the home directory

            shorting_target = 1, -- Shortens path to leave spaces in the window
            -- for other components. (terrible name, any suggestions?)
            symbols = {
              modified = '[+]', -- Text to show when the file is modified.
              readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[No Name]', -- Text to show for unnamed buffers.
              newfile = '[New]', -- Text to show for newly created file before first write
            },
            color = {
              fg = 'black',
              bg = 'white',
            },
          },
          'checkCwd()',
        },
        lualine_x = {
          'encoding',
          'codeiumStatus()',
          {
            'diagnostics',

            -- Table of diagnostic sources, available sources are:
            --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
            -- or a function that returns a table as such:
            --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
            sources = { 'nvim_diagnostic', 'nvim_lsp', 'nvim_workspace_diagnostic' },

            -- Displays diagnostics for the defined severity types
            sections = { 'error', 'warn', 'info', 'hint' },

            diagnostics_color = {
              -- Same values as the general color option can be used here.
              error = 'DiagnosticError', -- Changes diagnostics' error color.
              warn = 'DiagnosticWarn', -- Changes diagnostics' warn color.
              info = 'DiagnosticInfo', -- Changes diagnostics' info color.
              hint = 'DiagnosticHint', -- Changes diagnostics' hint color.
            },
            symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
            colored = true, -- Displays diagnostics status in color if set to true.
            update_in_insert = false, -- Update diagnostics in insert mode.
            always_visible = false, -- Show diagnostics even if there are none.
          },
        },
        lualine_y = { 'progress' },
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          { 'filename', file_status = true, newfile_status = true, path = 2, color = { fg = colors.terminal_black, bg = colors.bg_dark } },
        },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
