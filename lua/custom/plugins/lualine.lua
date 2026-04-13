return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    options = {
      theme = 'vscode',
      globalstatus = true,
      section_separators = { left = '', right = '' },
      component_separators = { left = '│', right = '│' },
      disabled_filetypes = {
        statusline = { 'neo-tree' },
        winbar = {},
      },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { { 'filename', path = 1 } },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    extensions = { 'neo-tree', 'lazy' },
  },
}
