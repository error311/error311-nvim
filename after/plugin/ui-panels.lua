local function fix_ui_panels()
  local hl = vim.api.nvim_set_hl
  local border = '#264f78'

  -- darker explorer / side panel
  hl(0, 'NeoTreeNormal', { bg = '#181818' })
  hl(0, 'NeoTreeNormalNC', { bg = '#181818' })
  hl(0, 'NeoTreeEndOfBuffer', { bg = '#181818', fg = '#181818' })
  hl(0, 'NeoTreeWinSeparator', { bg = '#181818', fg = '#2b2b2b' })
  hl(0, 'NeoTreeIndentMarker', { fg = '#3c3c3c', bg = '#181818' })
  hl(0, 'NeoTreeCursorLine', { bg = '#202020' })

  -- darker popup / bottom-panel feel
  hl(0, 'NormalFloat', { bg = '#181818', fg = border })
  hl(0, 'FloatBorder', { bg = '#181818', fg = border })
  hl(0, 'WhichKeyBorder', { bg = '#181818', fg = '#264f78' })
  hl(0, 'WhichKeyNormal', { bg = '#181818' })
  hl(0, 'WhichKeyTitle', { bg = '#181818', fg = '#d4d4d4' })

  -- telescope
  hl(0, 'TelescopeNormal', { bg = '#181818' })
  hl(0, 'TelescopeBorder', { bg = '#181818', fg = border })
  hl(0, 'TelescopePromptNormal', { bg = '#181818' })
  hl(0, 'TelescopePromptBorder', { bg = '#181818', fg = border })
  hl(0, 'TelescopeResultsBorder', { bg = '#181818', fg = border })
  hl(0, 'TelescopePreviewBorder', { bg = '#181818', fg = border })

  -- popup_setpos / right-click popup menu
  hl(0, 'Pmenu', { bg = '#181818', fg = '#d4d4d4' })
  hl(0, 'PmenuSel', { bg = '#264f78', fg = '#ffffff' })
  hl(0, 'PmenuBorder', { bg = '#181818', fg = '#264f78' })
end

fix_ui_panels()

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = fix_ui_panels,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'neo-tree',
  callback = function() vim.schedule(fix_ui_panels) end,
})
