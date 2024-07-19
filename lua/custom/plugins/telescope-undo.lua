return {
  'debugloop/telescope-undo.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  opts = {
    -- don't use `defaults = { }` here, do this in the main telescope spec
    extensions = {
      undo = {
        layout_strategy = 'horizontal',
        layout_config = {
          preview_width = 0.85,
          preview_cutoff = 70,
          prompt_position = 'top',
          mirror = false,
        },
        sorting_strategy = 'ascending',
        winblend = 10,
        use_delta = true,
        use_custom_command = nil,
        side_by_side = false,
        vim_diff_opts = { ctxlen = 10 },
        entry_format = '#$ID, $STAT, $TIME',
        time_format = '',
        saved_only = true,
      },
    },
  },
  config = function(_, opts)
    -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the configs for us. We won't use data, as everything is in it's own namespace (telescope defaults, as well as each extension).
    require('telescope').setup(opts)
    require('telescope').load_extension 'undo'
    vim.keymap.set('n', '<leader>cu', function()
      require('telescope').extensions.undo.undo { side_by_side = true }
    end, { desc = 'undo tree' })
  end,
}
