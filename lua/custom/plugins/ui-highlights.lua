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
      hl(0, 'NeoTreeFloatBorder', { fg = '#0078D4', bg = '#1E1E1E' })
      hl(0, 'NeoTreeFloatTitle', { fg = '#D4D4D4', bg = '#1E1E1E', bold = true })

      hl(0, 'NoiceCmdlinePopup', { fg = '#D4D4D4', bg = '#1E1E1E' })
      hl(0, 'NoiceCmdlinePopupBorder', { fg = '#0078D4', bg = '#1E1E1E' })
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

      hl(0, 'BlinkCmpMenu', { fg = '#D4D4D4', bg = '#181818' })
      hl(0, 'BlinkCmpMenuBorder', { fg = '#0078D4', bg = '#181818' })
      hl(0, 'BlinkCmpMenuSelection', { bg = '#0078D4' })
      hl(0, 'BlinkCmpLabel', { fg = '#D4D4D4' })
      hl(0, 'BlinkCmpLabelMatch', { fg = '#FFFFFF', bold = true })
      hl(0, 'BlinkCmpLabelDescription', { fg = '#808080' })
      hl(0, 'BlinkCmpSource', { fg = '#9CDCFE' })
      hl(0, 'BlinkCmpDoc', { fg = '#D4D4D4', bg = '#181818' })
      hl(0, 'BlinkCmpDocBorder', { fg = '#0078D4', bg = '#181818' })
      hl(0, 'BlinkCmpSignatureHelp', { fg = '#D4D4D4', bg = '#181818' })
      hl(0, 'BlinkCmpSignatureHelpBorder', { fg = '#0078D4', bg = '#181818' })

      hl(0, 'TelescopeNormal', { fg = '#D4D4D4', bg = '#1E1E1E' })
      hl(0, 'TelescopePromptNormal', { fg = '#D4D4D4', bg = '#1E1E1E' })
      hl(0, 'TelescopeResultsNormal', { fg = '#D4D4D4', bg = '#1E1E1E' })
      hl(0, 'TelescopePreviewNormal', { fg = '#D4D4D4', bg = '#1E1E1E' })

      hl(0, 'TelescopePromptBorder', { fg = '#0078D4', bg = '#1E1E1E' })
      hl(0, 'TelescopeResultsBorder', { fg = '#0078D4', bg = '#1E1E1E' })
      hl(0, 'TelescopePreviewBorder', { fg = '#0078D4', bg = '#1E1E1E' })
      hl(0, 'TelescopeBorder', { fg = '#0078D4', bg = '#1E1E1E' })

      hl(0, 'TelescopePromptTitle', { fg = '#FFFFFF', bg = '#1E1E1E', bold = true })
      hl(0, 'TelescopeResultsTitle', { fg = '#FFFFFF', bg = '#1E1E1E', bold = true })
      hl(0, 'TelescopePreviewTitle', { fg = '#FFFFFF', bg = '#1E1E1E', bold = true })

      hl(0, 'TelescopeSelection', { bg = '#264F78' })
      hl(0, 'TelescopeSelectionCaret', { fg = '#FFFFFF', bg = '#264F78' })
      hl(0, 'TelescopeMatching', { fg = '#FFFFFF', bold = true })
      hl(0, 'TelescopePromptPrefix', { fg = '#FFFFFF', bg = '#1E1E1E' })

      hl(0, 'LazyNormal', { fg = '#D4D4D4', bg = '#1E1E1E' })
      hl(0, 'LazyDir', { fg = '#D4D4D4' })
      hl(0, 'LazyValue', { fg = '#D4D4D4' })
      hl(0, 'DiffviewNormal', { fg = '#D4D4D4', bg = '#1E1E1E' })

      hl(0, 'DiffviewNormal', { fg = '#D4D4D4', bg = '#1E1E1E' })

      hl(0, 'DiffviewFolderSign', { fg = '#D4D4D4' })
      hl(0, 'DiffviewFilePanelTitle', { fg = '#D4D4D4', bold = true })
      hl(0, 'DiffviewFilePanelRootPath', { fg = '#D4D4D4', bold = true })
      hl(0, 'DiffviewPrimary', { fg = '#D4D4D4' })
      hl(0, 'DiffviewSecondary', { fg = '#808080' })

      hl(0, 'DiffAdd', { bg = '#1E3A24' })
      hl(0, 'DiffDelete', { bg = '#3A1B1B' })
      hl(0, 'DiffChange', { bg = '#1E2E4A' })
      hl(0, 'DiffText', { bg = '#264F78' })
    end

    fix_ui_hl()

    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = fix_ui_hl,
    })
    local function apply_ui_hl()
      vim.api.nvim_set_hl(0, 'TabLineSel', {
        fg = '#FFFFFF',
        bg = '#1F1F1F',
        underline = true,
        sp = '#0078D4',
      })
    end

    apply_ui_hl()

    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = apply_ui_hl,
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'neo-tree',
      callback = function()
        vim.schedule(fix_ui_hl)
      end,
    })
  end,
}
