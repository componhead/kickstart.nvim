return {
  'miversen33/sunglasses.nvim',
  config = {
    filter_type = 'NOSYNTAX',
    filter_percent = 0.25,
    vim.api.nvim_create_autocmd({
      'BufLeave',
    }, {
      callback = function()
        if vim.wo.diff then
          vim.cmd 'SunglassesDisable'
        end
      end,
    }),
    vim.api.nvim_create_autocmd({
      'WinClosed',
    }, {
      callback = function()
        if vim.wo.diff then
          vim.cmd 'SunglassesOff'
        end
      end,
    }),
  },
  event = 'BufEnter',
}
