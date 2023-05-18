return {
  'debugloop/telescope-undo.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  opts = {
    -- don't use `defaults = { }` here, do this in the main telescope spec
    extensions = {
      undo = {
        use_delta = true,
        use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
        side_by_side = false,
        diff_context_lines = vim.o.scrolloff,
        entry_format = 'state #$ID, $STAT, $TIME',
        time_format = '',
        saved_only = false,
      },
      -- no other extensions here, they can have their own spec too
    },
  },
  config = function(_, opts)
    -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
    -- configs for us. We won't use data, as everything is in it's own namespace (telescope
    -- defaults, as well as each extension).
    require('telescope').setup(opts)
    require('telescope').load_extension 'undo'
    local wk = require 'which-key'
    wk.register({
      u = {
        function()
          require('telescope').extensions.undo.undo { side_by_side = true }
        end,
        'undo tree',
      },
    }, { prefix = '<leader>c' })
  end,
}
