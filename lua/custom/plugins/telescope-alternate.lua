return {
  'otavioschwanck/telescope-alternate',
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  config = function()
    --   mappings = {
    --     { 'app/services/(.*)_services/(.*).rb', { -- alternate from services to contracts / models
    --       { 'app/contracts/[1]_contracts/[2].rb', 'Contract' }, -- Adding label to switch
    --       { 'app/models/**/*[1].rb', 'Model', true }, -- Ignore create entry (with true)
    --     } },
    --     { 'app/contracts/(.*)_contracts/(.*).rb', { { 'app/services/[1]_services/[2].rb', 'Service' } } }, -- from contracts to services
    --     -- Search anything on helper folder that contains pluralize version of model.
    --     --Example: app/models/user.rb -> app/helpers/foo/bar/my_users_helper.rb
    --     { 'app/models/(.*).rb', { { 'db/helpers/**/*[1:pluralize]*.rb', 'Helper' } } },
    --     { 'app/**/*.rb', { { 'spec/[1].rb', 'Test' } } }, -- Alternate between file and test
    --   },
    --   -- You also can use the verbose way to mapping:
    --   mappings = {
    --     { pattern = 'app/services/(.*)_services/(.*).rb', targets = {
    --         { template =  'app/contracts/[1]_contracts/[2].rb', label = 'Contract', enable_new = true } -- enable_new can be a function too.
    --       }
    --     },
    --     { pattern = 'app/contracts/(.*)_contracts/(.*).rb', targets = {
    --         { template =  'app/services/[1]_services/[2].rb', label = 'Service', enable_new = true }
    --       }
    --     },
    --   }
    --   presets = { 'rails', 'rspec', 'nestjs' }, -- Telescope pre-defined mapping presets
    --   open_only_one_with = 'current_pane', -- when just have only possible file, open it with.  Can also be horizontal_split and vertical_split
    --   transformers = { -- custom transformers
    --     change_to_uppercase = function(w) return my_uppercase_method(w) end
    --   },
    --   -- telescope_mappings = { -- Change the telescope mappings
    --   --   i = {
    --   --     open_current = '<CR>',
    --   --     open_horizontal = '<C-s>',
    --   --     open_vertical = '<C-v>',
    --   --     open_tab = '<C-t>',
    --   --   },
    --   --   n = {
    --   --     open_current = '<CR>',
    --   --     open_horizontal = '<C-s>',
    --   --     open_vertical = '<C-v>',
    --   --     open_tab = '<C-t>',
    --   --   }
    --   -- }
  end,
}
