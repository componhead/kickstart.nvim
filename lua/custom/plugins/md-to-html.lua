return {
  'realprogrammersusevim/md-to-html.nvim',
  cmd = { 'MarkdownToHTML', 'NewMarkdownToHTML' },
  config = function()
    require('which-key').register({
      h = {
        function()
          local command = 'NewMarkdownToHTML'
          vim.cmd(command)
        end,
        'create a html file from markdown',
        buffer = vim.api.nvim_get_current_buf(),
      },
      H = {
        function()
          local command = 'MarkdownToHTML'
          vim.cmd(command)
        end,
        'change markdown buffer to html',
        buffer = vim.api.nvim_get_current_buf(),
      },
    }, { prefix = '<leader>c' })
  end,
}
