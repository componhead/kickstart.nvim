return {
  "folke/twilight.nvim",
  opts = {

    dimming = {
      -- alpha = 0.80, -- amount of dimming
      -- we try to get the foreground from the highlight groups or fallback color
      color = { "Normal", "Comment" },
      -- term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
      inactive = true, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
    },

    -- context = math.floor(vim.o.lines * 0.5), -- amount of lines we will try to show around the current line
    context = 10,      -- amount of lines we will try to show around the current line
    treesitter = true, -- use treesitter when available for the filetype
    -- treesitter is used to automatically expand the visible text,
    -- but you can further control the types of nodes that should always be fully expanded
    expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
      "if_statement",
      "function",
      "method",
      "table",
    },
    exclude = {}, -- exclude these filetypes
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.register({
      t = { "<cmd>Twilight<CR>", "toggle twilight" },
    }, { prefix = "<leader>z" })
  end
}
