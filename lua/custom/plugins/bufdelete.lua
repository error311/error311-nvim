return {
  'famiu/bufdelete.nvim',
  cmd = { 'Bdelete', 'Bwipeout' },
  keys = {
    { '<leader>bd', '<cmd>Bdelete<CR>', desc = 'Delete buffer' },
    { '<leader>bD', '<cmd>Bwipeout<CR>', desc = 'Wipeout buffer' },
  },
}
