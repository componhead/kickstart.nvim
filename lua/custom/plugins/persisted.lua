return {
  "olimorris/persisted.nvim",
  lazy = false,
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
    vim.keymap.set('n', '<leader>Sl', '<cmd>SessionSelect<CR>', { desc = 'load session' })
    vim.keymap.set('n', '<leader>Ss', '<cmd>SessionSave<CR>', { desc = 'save session' })
    vim.keymap.set('n', '<leader>SD', '<cmd>SessionDelete<CR>', { desc = 'delete session' })

    local persisted = vim.api.nvim_create_augroup('persisted', {}) -- A global group for all your config autocommands
    vim.api.nvim_create_autocmd(
      { 'VimEnter', 'BufRead', 'BufNewFile' }, {
      pattern = '*',
      group = persisted,
      callback = function()
        local persisting_session = vim.g.persisting_session
        if persisting_session == '' then
          return
        end
        local session_file_name_start_idx, _ = persisting_session:find("%%")
        if session_file_name_start_idx == nil then
          vim.notify("No existing session to load.")
          return
        end
        local persisting_file_name = persisting_session:sub(tonumber(session_file_name_start_idx), -5)
        local normalized = persisting_file_name:gsub("%%", "/")
        vim.g.session_file_name = normalized
        vim.cmd ('cd' .. vim.g.session_file_name)
      end,
    })
  end,
}
