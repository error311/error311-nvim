return {
  'Mofiqul/vscode.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('vscode').setup {
      style = 'dark',
      transparent = false,
      italic_comments = false,
      italic_inlayhints = false,
      underline_links = true,
      terminal_colors = true,
    }

    vim.cmd.colorscheme 'vscode'

    local function fix_ui_hl()
      local hl = vim.api.nvim_set_hl

      hl(0, 'NeoTreeFloatNormal', { fg = '#D4D4D4', bg = '#1E1E1E' })
      hl(0, 'NeoTreeFloatBorder', { fg = '#569CD6', bg = '#1E1E1E' })
      hl(0, 'NeoTreeFloatTitle', { fg = '#D4D4D4', bg = '#1E1E1E', bold = true })

      hl(0, 'NoiceCmdlinePopup', { fg = '#D4D4D4', bg = '#1E1E1E' })
      hl(0, 'NoiceCmdlinePopupBorder', { fg = '#569CD6', bg = '#1E1E1E' })
      hl(0, 'NoiceCmdlinePrompt', { fg = '#D4D4D4', bold = true })
      hl(0, 'NoiceCmdlineIconCmdline', { fg = '#D4D4D4' })

      hl(0, 'CursorLine', { bg = '#2d3033' })
      hl(0, 'CursorLineNr', { fg = '#FFFFFF', bold = true })
      hl(0, 'NeoTreeCursorLine', { bg = '#252526' })

      hl(0, 'NeoTreeGitUntracked', { fg = '#73C991', italic = false, bold = false })
      hl(0, 'NeoTreeGitAdded', { fg = '#73C991', italic = false, bold = false })
      hl(0, 'NeoTreeGitStaged', { fg = '#73C991', italic = false, bold = false })
      hl(0, 'NeoTreeGitModified', { fg = '#D7BA7D', italic = false, bold = false })
      hl(0, 'NeoTreeGitUnstaged', { fg = '#D7BA7D', italic = false, bold = false })
      hl(0, 'NeoTreeGitDeleted', { fg = '#F14C4C', italic = false, bold = false })
      hl(0, 'NeoTreeGitConflict', { fg = '#F14C4C', italic = false, bold = false })
    end

    fix_ui_hl()

    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = fix_ui_hl,
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'neo-tree',
      callback = function()
        vim.schedule(fix_ui_hl)
      end,
    })
  end,
}
