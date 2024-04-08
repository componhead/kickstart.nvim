function url_encode(str)
  if str then
    str = str:gsub('\n', '\r\n')
    str = str:gsub('([^%w %-%_%.%~])', function(c)
      return string.format('%%%02X', string.byte(c))
    end)
    str = str:gsub(' ', '+')
  end
  return str
end

function _wezterm_osc_cwd()
  local hostname = vim.loop.os_uname().nodename
  local cwd = vim.fn.getcwd()
  local encoded_cwd = url_encode(cwd)

  -- The final sequence to be sent
  local osc7_seq = string.format('\027]7;file://%s/%s\027\\', hostname, encoded_cwd)

  -- Use io.write to send the sequence
  io.write(osc7_seq)

  local cwdDirname = vim.fn.fnamemodify(cwd, ':t')

  local osc1_seq = string.format('\x1b]2;' .. ' ' .. cwdDirname .. '\x1b\\')

  -- Use io.write to send the sequence
  io.write(osc1_seq)
end

-- Set up the autocmd to run the function whenever the directory changes
vim.api.nvim_exec(
  [[
    augroup OSC7
        autocmd!
        autocmd DirChanged * lua _wezterm_osc_cwd()
        autocmd SessionLoadPost * lua _wezterm_osc_cwd()
    augroup END
]],
  false
)
