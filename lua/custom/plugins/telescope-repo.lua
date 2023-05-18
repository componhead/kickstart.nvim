return {
  "cljoly/telescope-repo.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" }
  },
  config = function()
    require('telescope').setup {
      extensions = {
        repo = {
          list = {
            fd_opts = {
              "--no-ignore-vcs",
            },
            search_dirs = {
              "$DIR_REPOS",
            },
          },
        },
      },
    }
    vim.g.rooter_cd_cmd = 'lcd'

    require('telescope').load_extension('repo')
  end
}
