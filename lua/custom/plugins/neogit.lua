return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
    'nvim-telescope/telescope.nvim',
  },
  cmd = 'Neogit',
  keys = {
    { '<leader>gg', '<cmd>Neogit kind=split<cr>', desc = '[G]it status' },
    { '<leader>gc', '<cmd>Neogit commit<cr>', desc = '[G]it [C]ommit' },
  },
  opts = {
    integrations = {
      diffview = true,
      telescope = true,
    },
    kind = 'split',
    disable_commit_confirmation = false,
    signs = {
      section = { '', '' },
      item = { '', '' },
      hunk = { '', '' },
    },
    graph_style = 'unicode',
  },
}
