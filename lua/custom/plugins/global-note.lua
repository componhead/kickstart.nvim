return {
  'backdround/global-note.nvim',
  config = function()
    require('global-note').setup({
      -- Filename to use for default note (preset).
      -- string or fun(): string
      filename = "global.md",

      -- Directory to keep default note (preset).
      -- string or fun(): string
      directory = vim.env.PRIVATE_DOTFILES_ROOT .. '/notes',

      -- Floating window title.
      -- string or fun(): string
      title = "Global note",

      -- Ex command name.
      -- string
      command_name = "GlobalNote",

      -- A nvim_open_win config to show float window.
      -- table or fun(): table
      window_config = function()
        local window_height = vim.api.nvim_list_uis()[1].height
        local window_width = vim.api.nvim_list_uis()[1].width
        return {
          relative = "editor",
          border = "single",
          title = "Note",
          title_pos = "center",
          width = math.floor(0.7 * window_width),
          height = math.floor(0.85 * window_height),
          row = math.floor(0.05 * window_height),
          col = math.floor(0.15 * window_width),
        }
      end,

      -- It's called after the window creation.
      -- fun(buffer_id: number, window_id: number)
      post_open = function(_, _) end,

      -- Whether to use autosave. Autosave saves buffer on closing window
      -- or exiting Neovim.
      -- boolean
      autosave = true,

      -- Additional presets to create other global, project local, file local
      -- and other notes.
      -- { [name]: table } - tables there have the same fields as the current table.
      additional_presets = {
        changes_nvim = {
          filename = "changes_to_nvim.md",
          title = "Changes to nvim configuration",
          command_name = "ChangesNvimNote",
        },

        git = {
          filename = "git.md",
          title = "Tricks and notes on git",
          command_name = "GitNote",
        },

        js = {
          filename = "javascript.md",
          title = "Tricks and notes on javascript",
          command_name = "JavascriptNote",
        },

        ts = {
          filename = "typescript.md",
          title = "Tricks and notes on typescript",
          command_name = "TypescriptNote",
        },

        js_ts = {
          filename = "js_ts.md",
          title = "Tricks and notes javascript and typescript relation",
          command_name = "JsTsNote",
        },

        nvim = {
          filename = "nvim.md",
          title = "Tricks and notes on nvim",
          command_name = "NvimNote",
        },

        wezterm = {
          filename = "wezterm.md",
          title = "Tricks and notes on wezterm",
          command_name = "WeztermNote",
        },

        nix = {
          filename = "nix.md",
          title = "Tricks and notes on nix",
          command_name = "NixNote",
        },

        ghostscript = {
          filename = "ghostscript.md",
          title = "Tricks and notes on ghostscript",
          command_name = "GhostscriptNote",
        },

        ssh = {
          filename = "ssh.md",
          title = "Tricks and notes on ssh",
          command_name = "SshNote",
        },

        colloquio = {
          filename = "colloquio.md",
          title = "Tricks and notes on colloquio",
          command_name = "ColloquioNote",
        },

        book = {
          filename = "book.md",
          title = "Book",
          command_name = "BookNote",
        },
      },
    })
    vim.keymap.set("n", "<leader>nn", '<CMD>GlobalNote<CR>', { desc = "Open global note", })
    vim.keymap.set("n", "<leader>ng", '<CMD>GitNote<CR>', { desc = "Open git note", })
    vim.keymap.set("n", "<leader>nh", '<CMD>GhostscriptNote<CR>', { desc = "Open ghostscript note", })
    vim.keymap.set("n", "<leader>nj", '<CMD>JavascriptNote<CR>', { desc = "Open javascript note", })
    vim.keymap.set("n", "<leader>nJ", '<CMD>JsTsNote<CR>', { desc = "Open js_ts note", })
    vim.keymap.set("n", "<leader>ns", '<CMD>SshNote<CR>', { desc = "Open ssh note", })
    vim.keymap.set("n", "<leader>nt", '<CMD>TypescriptNote<CR>', { desc = "Open global note", })
    vim.keymap.set("n", "<leader>nv", '<CMD>NvimNote<CR>', { desc = "Open nvim note", })
    vim.keymap.set("n", "<leader>nw", '<CMD>WeztermNote<CR>', { desc = "Open wezterm note", })
    vim.keymap.set("n", "<leader>nx", '<CMD>NixNote<CR>', { desc = "Open nix note", })
  end
}

