return {
  'sindrets/diffview.nvim',
  cmd = {
    'DiffviewOpen',
    'DiffviewClose',
    'DiffviewToggleFiles',
    'DiffviewFocusFiles',
    'DiffviewFileHistory',
  },
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = '[G]it [D]iffview' },
    { '<leader>gD', '<cmd>DiffviewClose<cr>', desc = '[G]it close [D]iffview' },
    { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = '[G]it file [H]istory' },
    { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = '[G]it repo [H]istory' },
  },
  opts = {
    enhanced_diff_hl = true,
    use_icons = true,
    show_help_hints = false,

    icons = {
      folder_closed = '',
      folder_open = '',
    },
    signs = {
      fold_closed = '',
      fold_open = '',
      done = '✓',
    },

    view = {
      default = {
        layout = 'diff2_horizontal',
        winbar_info = true,
      },
      merge_tool = {
        layout = 'diff3_horizontal',
        winbar_info = true,
      },
      file_history = {
        layout = 'diff2_horizontal',
        winbar_info = true,
      },
    },

    file_panel = {
      listing_style = 'tree',
      tree_options = {
        flatten_dirs = false,
        folder_statuses = 'always',
      },
      win_config = {
        position = 'left',
        width = 35,
      },
    },

    file_history_panel = {
      win_config = {
        position = 'bottom',
        height = 14,
      },
    },

    hooks = {
      diff_buf_read = function()
        vim.opt_local.wrap = false
        vim.opt_local.list = false
        vim.opt_local.colorcolumn = {}
        vim.opt_local.cursorline = true
        vim.opt_local.relativenumber = false
      end,
    },
  },
}
