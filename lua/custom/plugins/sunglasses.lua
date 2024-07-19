return {
  'miversen33/sunglasses.nvim',
  config = {
    filter_type = 'SHADE',
    filter_percent = 0.5,
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
        vim.cmd 'SunglassesOff'
      end,
    }),
    vim.keymap.set('n', '<leader>ts', '<cmd>SunglassesEnableToggle<CR>', { desc = 'toggle sunglasses' }),
  },
  event = 'BufEnter',
}
