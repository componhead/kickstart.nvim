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

function Is_in_root(filename)
  local dir = Get_root '.git' or vim.fn.getcwd()
  return filename:match(dir) ~= nil
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

vim.api.nvim_create_user_command('IsCurrentBufferInRoot', function()
  return Is_in_root(vim.fn.expand('%:p'))
end, {})

function print_table(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. print_table(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

local cd_git_root = function(args)
  local dir = Get_root '.git' or vim.fn.getcwd()
  if(args["args"] == '') then
    vim.cmd('cd ' .. dir)
  elseif args["args"] == 'tab' then
    vim.cmd('tcd ' .. dir)
  elseif args["args"] == 'window' then
    vim.cmd('lcd ' .. dir)
  end
end

local cd_node_root = function(args)
  local dir = Get_root 'package.json' or vim.fn.getcwd()
  if(args["args"] == '') then
    vim.cmd('cd ' .. dir)
  elseif args["args"] == 'tab' then
    vim.cmd('tcd ' .. dir)
  elseif args["args"] == 'window' then
    vim.cmd('lcd ' .. dir)
  end
end

vim.api.nvim_create_user_command('CdGitRoot', cd_git_root, { nargs = '?', desc = 'change cwd to git root' })

vim.api.nvim_create_user_command('CdNodeRoot', cd_node_root , { nargs = '?', desc = 'change cwd to node_modules'})

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
