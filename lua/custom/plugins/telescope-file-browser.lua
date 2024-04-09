return {
  'nvim-telescope/telescope-file-browser.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  config = function()
    local open_using = function(finder, description)
      return function(prompt_bufnr)
        local current_finder = require('telescope.actions.state').get_current_picker(prompt_bufnr).finder
        local entry = require('telescope.actions.state').get_selected_entry()

        local entry_path
        if entry.ordinal == '..' then
          entry_path = require('plenary.path'):new(current_finder.path)
        else
          entry_path = require('telescope.actions.state').get_selected_entry().Path
        end

        local path = entry_path:is_dir() and entry_path:absolute() or entry_path:parent():absolute()
        require('telescope.actions').close(prompt_bufnr)
        finder { cwd = path, desc = description }
      end
    end

    local fb_actions = require 'telescope._extensions.file_browser.actions'

    require('telescope').setup {
      extensions = {
        file_browser = {
          layout_strategy = 'vertical',
          layout_config = {
            prompt_position = 'top',
            width = 0.5,
            height = 0.9,
            preview_height = 0.4,
            mirror = true,
          },
          sorting_strategy = 'ascending',
          winblend = 10,
          path = vim.loop.cwd(),
          cwd = vim.loop.cwd(),
          cwd_to_path = false,
          grouped = false,
          files = true,
          add_dirs = true,
          depth = 1,
          auto_depth = false,
          select_buffer = false,
          hidden = { file_browser = false, folder_browser = false },
          respect_gitignore = vim.fn.executable 'fd' == 1,
          no_ignore = false,
          follow_symlinks = false,
          browse_files = require('telescope._extensions.file_browser.finders').browse_files,
          browse_folders = require('telescope._extensions.file_browser.finders').browse_folders,
          hide_parent_dir = false,
          collapse_dirs = false,
          prompt_path = false,
          quiet = false,
          dir_icon = '',
          dir_icon_hl = 'Default',
          display_stat = { date = true, size = true, mode = true },
          use_fd = true,
          git_status = true,
          mappings = {
            ['i'] = {
              ['<A-c>'] = fb_actions.create,
              ['<S-CR>'] = fb_actions.create_from_prompt,
              ['<A-r>'] = fb_actions.rename,
              ['<A-m>'] = fb_actions.move,
              ['<A-y>'] = fb_actions.copy,
              ['<A-d>'] = fb_actions.remove,
              ['<C-o>'] = fb_actions.open,
              ['<C-g>'] = fb_actions.goto_parent_dir,
              ['<C-e>'] = fb_actions.goto_home_dir,
              ['<C-w>'] = fb_actions.goto_cwd,
              ['<C-t>'] = fb_actions.change_cwd,
              ['<C-f>'] = fb_actions.toggle_browser,
              ['<C-h>'] = fb_actions.toggle_hidden,
              ['<C-s>'] = fb_actions.toggle_all,
              ['<bs>'] = fb_actions.backspace,
            },
            ['n'] = {
              ['<M-f>'] = open_using(require('telescope.builtin').find_files, 'find files under directory'),
              ['<M-g>'] = open_using(require('telescope.builtin').live_grep, 'grep text under directory'),
              ['c'] = fb_actions.create,
              ['r'] = fb_actions.rename,
              ['m'] = fb_actions.move,
              ['y'] = fb_actions.copy,
              ['d'] = fb_actions.remove,
              ['o'] = fb_actions.open,
              ['g'] = fb_actions.goto_parent_dir,
              ['e'] = fb_actions.goto_home_dir,
              ['w'] = fb_actions.goto_cwd,
              ['t'] = fb_actions.change_cwd,
              ['f'] = fb_actions.toggle_browser,
              ['h'] = fb_actions.toggle_hidden,
              ['s'] = fb_actions.toggle_all,
            },
          },
          hijack_netrw = true,
        },
      },
    }
    require('telescope').load_extension 'file_browser'
    local wk = require 'which-key'
    wk.register({
      ['\\'] = {
        function()
          local exist = vim.fn.getreg '%'
          if exist == '' then
            require('telescope').extensions.file_browser.file_browser {
              path = tostring(vim.loop.cwd()),
              prompt_path = true,
            }
          else
            require('telescope').extensions.file_browser.file_browser {
              path = '%:p:h',
              prompt_path = true,
            }
          end
        end,
        'browse files from directory',
        silent = true,
      },
    }, { prefix = '<leader>\\' })
  end,
}
