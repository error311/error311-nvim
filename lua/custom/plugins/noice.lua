return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  opts = {
    lsp = {
      progress = {
        enabled = true,
      },
      hover = {
        enabled = true,
      },
      signature = {
        enabled = true,
      },
    },
    cmdline = {
      enabled = true,
      view = 'cmdline_popup',
    },
    messages = {
      enabled = true,
      view = 'notify',
      view_error = 'notify',
      view_warn = 'notify',
      view_history = 'messages',
      view_search = false,
    },
    popupmenu = {
      enabled = false,
    },
    notify = {
      enabled = true,
      view = 'notify',
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = true,
    },
  },
}
