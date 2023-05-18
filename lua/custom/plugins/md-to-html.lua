return {
  'realprogrammersusevim/md-to-html.nvim',
  cmd = { 'MarkdownToHTML', 'NewMarkdownToHTML' },
  config = function()
    require('which-key').add {
      {
        '<leader>ch',
        function()
          local command = 'NewMarkdownToHTML'
          vim.cmd(command)
        end,
        desc = 'create a html file from markdown',
      },
      {
        '<leader>cH',
        function()
          local command = 'MarkdownToHTML'
          vim.cmd(command)
        end,
        desc = 'change markdown buffer to html',
      },
    }
  end,
}
