local function fix_gitsigns_colors()
  local hl = vim.api.nvim_set_hl

  -- exact VS Code Dark Modern gutter colors
  hl(0, 'GitSignsAdd', { fg = '#2EA043' })
  hl(0, 'GitSignsChange', { fg = '#0078D4' })
  hl(0, 'GitSignsDelete', { fg = '#F85149' })

  -- optional matching variants
  hl(0, 'GitSignsChangedelete', { fg = '#0078D4' })
  hl(0, 'GitSignsTopdelete', { fg = '#F85149' })
  hl(0, 'GitSignsUntracked', { fg = '#2EA043' })
end

fix_gitsigns_colors()

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = fix_gitsigns_colors,
})
