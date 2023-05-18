return {
  'shatur/neovim-session-manager',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local Path = require 'plenary.path'
    require('session_manager').setup {
      sessions_dir = Path:new(vim.fn.stdpath 'data', 'sessions'), -- The directory where the session files will be saved.
      -- session_filename_to_dir = session_filename_to_dir,                          -- Function that replaces symbols into separators and colons to transform filename into a session directory.
      -- dir_to_session_filename = dir_to_session_filename, -- Function that replaces separators and colons into special symbols to transform session directory into a filename. Should use `vim.loop.cwd()` if the passed `dir` is `nil`.
      path_replacer = '__', -- The character to which the path separator will be replaced for session files.
      colon_replacer = '++', -- The character to which the colon symbol will be replaced for session files.
      autoload_mode = require('session_manager.config').AutoloadMode.LastSession, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
      autosave_last_session = true, -- Automatically save last session on exit and on session switch.
      autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
      autosave_ignore_dirs = {}, -- A list of directories where the session will not be autosaved.
      autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
        'gitcommit',
        'gitrebase',
      },
      autosave_ignore_buftypes = {}, -- All buffers of these bufer types will be closed before the session is saved.
      autosave_only_in_session = true, -- Always autosaves session. If true, only autosaves after a session is active.
      max_path_length = 80, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
    }

    local wk = require 'which-key'
    wk.add {
      { '<leader>Sd', '<cmd>SessionManager load_current_dir_session<CR>', desc = 'load current dir session' },
      { '<leader>Sl', '<cmd>SessionManager load_session<CR>', desc = 'load session' },
      { '<leader>Ss', '<cmd>SessionManager save_current_session<CR>', desc = 'save session' },
      { '<leader>SD', '<cmd>SessionManager delete_session<CR>', desc = 'delete session' },
      { '<leader>SL', '<cmd>SessionManager load_last_session<CR>', desc = 'load last session' },
    }
  end,
}
