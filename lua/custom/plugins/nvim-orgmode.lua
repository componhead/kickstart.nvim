return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  config = function()
    -- Setup treesitter
    require('nvim-treesitter.configs').setup {
      highlight = {
        enable = true,
      },
      ensure_installed = { 'org' },
    }

    -- Setup orgmode
    require('orgmode').setup {
      org_agenda_files = '$PRIVATE_DOTFILES/notes/*',
      org_default_notes_file = '$PRIVATE_DOTFILES/notes/index.org',
    }
  end,
}
