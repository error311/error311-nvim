return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
    'antosha417/nvim-lsp-file-operations',
  },
  keys = {
    { '<leader>e', ':Neotree toggle reveal_force_cwd left<CR>', desc = 'Explorer' },
    { '<leader>o', ':Neotree focus filesystem left<CR>', desc = 'Focus Explorer' },
  },
  opts = {
    close_if_last_window = false,
    popup_border_style = 'single',
    enable_git_status = true,
    enable_diagnostics = false,

    open_files_do_not_replace_types = {
      'terminal',
      'Trouble',
      'qf',
      'edgy',
      'neominimap',
    },

    source_selector = {
      winbar = true,
      statusline = false,
    },

    filesystem = {
      hijack_netrw_behavior = 'open_default',
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
      },
      use_libuv_file_watcher = true,
      window = {
        position = 'left',
        width = 36,
        mappings = {
          ['<cr>'] = 'open',
          ['l'] = 'open',
          ['h'] = 'close_node',
          ['a'] = 'add',
          ['A'] = 'add_directory',
          ['d'] = 'delete',
          ['r'] = 'rename',
          ['m'] = 'move',
          ['y'] = 'copy_to_clipboard',
          ['x'] = 'cut_to_clipboard',
          ['p'] = 'paste_from_clipboard',
          ['R'] = 'refresh',
          ['.'] = 'toggle_hidden',
          ['/'] = 'fuzzy_finder',
          ['i'] = 'show_file_details',
          ['<'] = 'prev_source',
          ['>'] = 'next_source',
        },
      },
    },

    window = {
      mappings = {
        ['<space>'] = 'none',
        ['<Tab>'] = 'next_source',
        ['<S-Tab>'] = 'prev_source',
      },
    },

    default_component_configs = {
      indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
        indent_marker = '│',
        last_indent_marker = '└',
        highlight = 'NeoTreeIndentMarker',
      },
      icon = {
        folder_closed = '',
        folder_open = '',
        folder_empty = '',
        default = '󰈔',
      },
      modified = {
        symbol = '',
      },
      name = {
        use_git_status_colors = true,
      },
      git_status = {
        symbols = {
          added = 'A',
          modified = 'M',
          deleted = 'D',
          renamed = 'R',
          untracked = 'U',
          ignored = '',
          unstaged = '',
          staged = '',
          conflict = '!',
        },
      },
    },
  },
}
