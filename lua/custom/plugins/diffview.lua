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
    view = {
      default = {
        layout = 'diff2_horizontal',
      },
      merge_tool = {
        layout = 'diff3_horizontal',
      },
      file_history = {
        layout = 'diff2_horizontal',
      },
    },
    file_panel = {
      listing_style = 'tree',
      win_config = {
        position = 'left',
        width = 35,
      },
    },
  },
}
