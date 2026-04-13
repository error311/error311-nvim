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

    local function fix_neotree_git_hl()
      local hl = vim.api.nvim_set_hl

      hl(0, 'NeoTreeGitUntracked', { fg = '#73C991', italic = false, bold = false })
      hl(0, 'NeoTreeGitAdded', { fg = '#73C991', italic = false, bold = false })
      hl(0, 'NeoTreeGitStaged', { fg = '#73C991', italic = false, bold = false })

      hl(0, 'NeoTreeGitModified', { fg = '#D7BA7D', italic = false, bold = false })
      hl(0, 'NeoTreeGitUnstaged', { fg = '#D7BA7D', italic = false, bold = false })

      hl(0, 'NeoTreeGitDeleted', { fg = '#F14C4C', italic = false, bold = false })
      hl(0, 'NeoTreeGitConflict', { fg = '#F14C4C', italic = false, bold = false })
    end

    fix_neotree_git_hl()

    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = fix_neotree_git_hl,
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'neo-tree',
      callback = function() vim.schedule(fix_neotree_git_hl) end,
    })
  end,
}
