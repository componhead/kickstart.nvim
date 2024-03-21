return {
  'jackMort/ChatGPT.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'folke/trouble.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('chatgpt').setup {
      -- api_key_cmd = 'op read op://Personal/OpenAI/api_key --no-newline',
    }
    local wk = require 'which-key'
    wk.register({
      g = { '<cmd>ChatGPT<CR>', 'ask to chatgpt' },
    }, { prefix = '<leader>ia' })
    wk.register({
      g = { '<cmd>ChatGPTCompleteCode<CR>', 'complete by chatGPT' },
    }, { prefix = '<leader>ic' })
    wk.register({
      g = {
        function()
          require('chatgpt').edit_with_instructions()
        end,
        'edit with instructions to chatgpt',
      },
    }, { prefix = '<leader>ie' })
    wk.register({
      g = { '<cmd>ChatGPTActAs<CR>', 'chatgpt act as...' },
    }, { prefix = '<leader>im' })
  end,
}
