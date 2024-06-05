-- Function to find the git root directory based on the current buffer's path
function Get_git_root()
  local dot_git_file = vim.fn.findfile('.git', '.;')
  if dot_git_file == '' then
    local dot_git_path = vim.fn.finddir('.git', '.;')
    if dot_git_path == '' then
      return nil
    else
      local git_root = vim.fn.fnamemodify(dot_git_path, ':p:h:h')
      return git_root
    end
  else
    local git_root = vim.fn.fnamemodify(dot_git_file, ':p:h')
    return git_root
  end
end

vim.api.nvim_create_user_command('CdGitRoot', function()
  vim.api.nvim_set_current_dir(Get_git_root())
end, {})

vim.api.nvim_create_user_command('BufOnly', function()
  pcall(function()
    vim.fn.execute('%bd|e#|bd#', true)
  end)
end, { desc = 'delete all buffers except current' })

vim.api.nvim_create_user_command('DelAllMarks', function()
  pcall(function()
    vim.fn.execute('delmarks a-zA-Z0-9\\"<>[]^.', true)
    vim.fn.execute('<cmd>wshada!<cr>', true)
    vim.fn.execute("echo 'All marks deleted'", true)
  end)
end, { desc = 'delete all marks (system too)' })

vim.api.nvim_create_user_command('Browse', function(opts)
  -- Linux
  -- vim.fn.system { 'xdg-open', opts.fargs[1] }
  -- Macos
  vim.fn.system { 'open', opts.fargs[1] }
end, { nargs = 1 })
