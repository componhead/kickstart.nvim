return {
  'realprogrammersusevim/md-to-html.nvim',
  cmd = { 'MarkdownToHTML', 'NewMarkdownToHTML' },
  config = function()
    vim.keymap.set('n', '<leader>ch', function()
      local command = 'NewMarkdownToHTML'
      vim.cmd(command)
    end, { desc = 'create a html file from markdown' })
    vim.keymap.set('n', '<leader>cH', function()
      local command = 'MarkdownToHTML'
      vim.cmd(command)
    end, { desc = 'change markdown buffer to html' })
  end,
}
