local function fix_ui_panels()
  local hl = vim.api.nvim_set_hl
  local border = '#0078D4'

  -- darker explorer / side panel
  hl(0, 'NeoTreeNormal', { bg = '#181818' })
  hl(0, 'NeoTreeNormalNC', { bg = '#181818' })
  hl(0, 'NeoTreeEndOfBuffer', { bg = '#181818', fg = '#181818' })
  hl(0, 'NeoTreeWinSeparator', { bg = '#181818', fg = '#2b2b2b' })
  hl(0, 'NeoTreeIndentMarker', { fg = '#3c3c3c', bg = '#181818' })

  -- darker popup / bottom-panel feel
  hl(0, 'NormalFloat', { bg = '#181818', fg = border })
  hl(0, 'FloatBorder', { bg = '#181818', fg = border })
  hl(0, 'WhichKeyBorder', { bg = '#181818', fg = '#0078D4' })
  hl(0, 'WhichKeyNormal', { bg = '#181818' })
  hl(0, 'WhichKeyTitle', { bg = '#181818', fg = '#d4d4d4' })

  -- popup_setpos / right-click popup menu
  hl(0, 'Pmenu', { bg = '#181818', fg = '#d4d4d4' })
  hl(0, 'PmenuSel', { bg = '#0078D4', fg = '#ffffff' })
  hl(0, 'PmenuBorder', { bg = '#181818', fg = '#0078D4' })
end

fix_ui_panels()

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = fix_ui_panels,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'neo-tree',
  callback = function()
    vim.schedule(fix_ui_panels)
  end,
})
