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
    wk.add {
      mode = 'n',
      { '<leader>iag', '<cmd>ChatGPT<CR>', desc = 'ask to chatgpt' },
      { '<leader>img', '<cmd>ChatGPTActAs<CR>', desc = 'chatgpt act as...' },
    }
    wk.add {
      mode = 'v',
      { '<leader>icg', '<cmd>ChatGPTCompleteCode<CR>', desc = 'complete by chatGPT' },
      {
        '<leader>ieg',
        function()
          require('chatgpt').edit_with_instructions()
        end,
        desc = 'edit with instructions to chatgpt',
      },
    }
  end,
}
