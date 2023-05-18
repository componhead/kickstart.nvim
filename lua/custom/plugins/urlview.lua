return {
  "axieax/urlview.nvim",
  config = function()
    require('urlview').setup {
      default_action = "system",
      jump = {
        prev = "[U",
        next = "]U",
      },
    }
    local wk = require("which-key")
    wk.register({
      l = {
        "<cmd>UrlView lazy<CR>",
        "show lazy plugins links",
        silent = true
      },
      u = {
        "<cmd>UrlView buffer<CR>",
        "show links in current buffer",
        silent = true
      },

    }, { prefix = "<leader>\\" })
  end
}
