return { 
  -- brew install tabbyml/tabby/tabby
  -- # Start server with StarCoder-1B
  -- tabby serve --device metal --model StarCoder-1B --chat-model Qwen2-1.5B-Instruct
  "TabbyML/vim-tabby",
  lazy = false,
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  init = function()
    vim.g.tabby_agent_start_command = {"npx", "tabby-agent", "--stdio"}
    vim.g.tabby_inline_completion_trigger = "auto"
  end
}
