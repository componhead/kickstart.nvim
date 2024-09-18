-- Function to find the git root directory based on the current buffer's path
function Get_root(file_name)
  local file = vim.fn.findfile(file_name, '.;')
  if file == '' then
    local path = vim.fn.finddir(file_name, '.;')
    if path == '' then
      return nil
    else
      local root = vim.fn.fnamemodify(path, ':p:h:h')
      return root
    end
  else
    local root = vim.fn.fnamemodify(file, ':p:h')
    return root
  end
end

function Get_list_paths(list)
  local paths = {}
  local hash = {}
  for k in pairs(list) do
    local path = vim.fn.bufname(list[k]['bufnr']) -- extract path from quick fix list
    if not hash[path] then -- add to paths table, if not already appeared
      paths[#paths + 1] = path
      hash[path] = true -- remember existing paths
    end
  end
  -- show search scope with message
  vim.notify('find in ...\n  ' .. table.concat(paths, '\n  '))
  return paths
end

vim.api.nvim_create_user_command('ShowPaths', function()
  return vim.api.nvim_echo({
    { vim.fn.expand '%:p:h' .. '\n', 'Title' },
    { vim.fn.expand '%:h' .. '\n', 'Title' },
    { vim.fn.expand '%:t', 'WarningMsg' },
  }, false, {})
end, {})

vim.api.nvim_create_user_command('CdFileDir', function()
  local dir = vim.fn.expand '%:h'
  vim.api.nvim_set_current_dir(dir)
end, {})

vim.api.nvim_create_user_command('CdWindowGitRoot', function()
  local dir = Get_root '.git' or vim.fn.getcwd()
  vim.cmd('lcd ' .. dir)
end, {})

vim.api.nvim_create_user_command('CdTabGitRoot', function()
  local dir = Get_root '.git' or vim.fn.getcwd()
  vim.cmd('tcd ' .. dir)
end, {})

vim.api.nvim_create_user_command('CdGitRoot', function()
  local dir = Get_root '.git' or vim.fn.getcwd()
  vim.api.nvim_set_current_dir(dir)
end, {})

vim.api.nvim_create_user_command('CdNodeRoot', function()
  local dir = Get_root 'package.json' or vim.fn.getcwd()
  vim.api.nvim_set_current_dir(dir)
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
