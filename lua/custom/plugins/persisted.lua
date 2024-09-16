return {
  "olimorris/persisted.nvim",
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require("persisted").setup({
      save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- Resolves to ~/.local/share/nvim/sessions/
      follow_cwd = false, -- Change the session file to match any change in the cwd?
      use_git_branch = true,
      autostart = true,
      autoload = true,
      allowed_dirs = {}, -- Table of dirs that the plugin will start and autoload from
      ignored_dirs = {}, -- Table of dirs that are ignored for starting and autoloading
      should_save = function()
        return true
      end,
      on_autoload_no_session = function()
        vim.notify("No existing session to load.")
      end,
    })
    vim.keymap.set('n', '<leader>SS', function()
      vim.cmd'Telescope persisted'
    end, { desc = 'load session' })
    vim.keymap.set('n', '<leader>Ss', function()
      vim.cmd'SessionSave'
    end, { desc = 'save session' })
    vim.keymap.set('n', '<leader>SD', function()
      vim.cmd'SessionDelete'
    end, { desc = 'delete session' })
    vim.keymap.set('n', '<leader>Sl', function()
      vim.cmd'SessionLoadLast'
    end, { desc = 'load last session' })

    local persisted = vim.api.nvim_create_augroup('persisted', {}) -- A global group for all your config autocommands
    vim.api.nvim_create_autocmd(
      { 'User' }, {
        pattern = {'PersistedLoadPost','PersistedTelescopeLoadPost'},
        group = persisted,
        callback = function()
          local persisting_session = vim.g.persisting_session
          if persisting_session == nil then
            return
          end
          local session_file_name_start_idx, _ = persisting_session:find("%%")
          if session_file_name_start_idx == nil then
            vim.notify("Error: no previous session to load.")
            return
          end
          local cwd_file_name = persisting_session:sub(tonumber(session_file_name_start_idx), -5)
          local normalized = cwd_file_name:gsub("%%", "/")
          local cwd_branch_start_idx, _ = cwd_file_name:find("@@")
          if(cwd_branch_start_idx == nil) then
            vim.g.session_file_path = normalized
          else
            vim.g.session_file_path = normalized:sub(1, tonumber(cwd_branch_start_idx) - 1)
          end
          vim.cmd ('cd' .. vim.g.session_file_path)
          vim.notify("Session loaded: " .. vim.g.session_file_path)
        end,
      })
  end,
}
