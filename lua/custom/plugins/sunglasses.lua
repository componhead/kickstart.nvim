return {
  'miversen33/sunglasses.nvim',
  config = {
    filter_type = 'NOSYNTAX',
    filter_percent = 0.5,
    excluded_filetypes = {
      'dashboard',
      'lspsagafinder',
      'packer',
      'checkhealth',
      'mason',
      'NvimTree',
      'neo-tree',
      'plugin',
      'lazy',
      'TelescopePrompt',
      'alpha',
      'toggleterm',
      'sagafinder',
      'better_term',
      'fugitiveblame',
      'starter',
      'NeogitPopup',
      'NeogitStatus',
      'DiffviewFiles',
      'DiffviewFileHistory',
      'DressingInput',
      'spectre_panel',
      'zsh',
      'registers',
      'startuptime',
      'OverseerList',
      'Outline',
      'Navbuddy',
      'noice',
      'notify',
      'saga_codeaction',
      'sagarename',
      'qf',
    },
    excluded_highlights = {
      'WinSeparator',
      { 'lualine_.*', glob = true },
    },
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
