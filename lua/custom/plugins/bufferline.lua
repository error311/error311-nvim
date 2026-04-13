return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  event = 'VeryLazy',
  opts = {
    options = {
      mode = 'buffers',
      separator_style = 'slant',
      diagnostics = false,
      always_show_bufferline = true,
      show_buffer_close_icons = true,
      show_close_icon = false,
      color_icons = true,

      indicator = {
        style = 'underline',
      },

      modified_icon = '●',
      left_trunc_marker = '',
      right_trunc_marker = '',

      close_command = function(bufnum) require('bufdelete').bufdelete(bufnum, true) end,
      right_mouse_command = function(bufnum) require('bufdelete').bufdelete(bufnum, true) end,

      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Explorer',
          highlight = 'Directory',
          text_align = 'left',
        },
      },
    },

    highlights = {
      fill = {
        bg = '#181818',
      },

      background = {
        fg = '#9D9D9D',
        bg = '#181818',
      },

      buffer_visible = {
        fg = '#9D9D9D',
        bg = '#181818',
      },

      buffer_selected = {
        fg = '#FFFFFF',
        bg = '#1F1F1F',
        bold = false,
        italic = false,
        underline = true,
        sp = '#0078D4',
      },

      modified = {
        fg = '#9D9D9D',
        bg = '#181818',
      },

      modified_visible = {
        fg = '#9D9D9D',
        bg = '#181818',
      },

      modified_selected = {
        fg = '#FFFFFF',
        bg = '#1F1F1F',
        underline = true,
        sp = '#0078D4',
      },

      separator = {
        fg = '#2B2B2B',
        bg = '#181818',
      },

      separator_visible = {
        fg = '#2B2B2B',
        bg = '#181818',
      },

      separator_selected = {
        fg = '#2B2B2B',
        bg = '#1F1F1F',
      },

      close_button = {
        fg = '#9D9D9D',
        bg = '#181818',
      },

      close_button_visible = {
        fg = '#9D9D9D',
        bg = '#181818',
      },

      close_button_selected = {
        fg = '#FFFFFF',
        bg = '#1F1F1F',
        underline = true,
        sp = '#0078D4',
      },
    },
  },
  keys = {
    { '<S-h>', '<cmd>BufferLineCyclePrev<CR>', desc = 'Prev buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<CR>', desc = 'Next buffer' },
    { '<Tab>', '<cmd>BufferLineCycleNext<CR>', desc = 'Next buffer' },
    { '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', desc = 'Prev buffer' },
    { '<leader>bp', '<cmd>BufferLineTogglePin<CR>', desc = 'Pin buffer' },
    {
      '<leader>q',
      function() require('bufdelete').bufdelete(0, true) end,
      desc = 'Close current buffer',
    },
  },
}
