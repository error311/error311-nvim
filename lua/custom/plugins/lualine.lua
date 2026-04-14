return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = function()
    local function mode_or_macro()
      local reg = vim.fn.reg_recording()
      if reg ~= '' then
        return 'MACRO @' .. reg
      end

      local mode = vim.api.nvim_get_mode().mode
      local names = {
        n = 'NORMAL',
        no = 'NORMAL',
        nov = 'NORMAL',
        noV = 'NORMAL',
        ['no\22'] = 'NORMAL',
        niI = 'NORMAL',
        niR = 'NORMAL',
        niV = 'NORMAL',
        nt = 'NORMAL',
        v = 'VISUAL',
        V = 'V-LINE',
        ['\22'] = 'V-BLOCK',
        s = 'SELECT',
        S = 'S-LINE',
        ['\19'] = 'S-BLOCK',
        i = 'INSERT',
        ic = 'INSERT',
        ix = 'INSERT',
        R = 'REPLACE',
        Rc = 'REPLACE',
        Rx = 'REPLACE',
        Rv = 'V-REPLACE',
        c = 'COMMAND',
        cv = 'COMMAND',
        ce = 'COMMAND',
        r = 'PROMPT',
        rm = 'MORE',
        ['r?'] = 'CONFIRM',
        ['!'] = 'SHELL',
        t = 'TERMINAL',
      }

      return names[mode] or mode
    end

    local group = vim.api.nvim_create_augroup('error311_lualine_macro', { clear = true })

    vim.api.nvim_create_autocmd('RecordingEnter', {
      group = group,
      callback = function()
        vim.cmd('redrawstatus')
      end,
    })

    vim.api.nvim_create_autocmd('RecordingLeave', {
      group = group,
      callback = function()
        vim.schedule(function()
          vim.cmd('redrawstatus')
        end)
      end,
    })

    return {
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
        lualine_a = { mode_or_macro },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      extensions = { 'neo-tree', 'lazy' },
    }
  end,
}
