vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('error311-startup-directory', { clear = true }),
  callback = function(args)
    if vim.fn.argc() ~= 1 then return end

    if vim.fn.isdirectory(args.file) ~= 1 then return end

    local dir = vim.fn.fnameescape(args.file)

    vim.schedule(function()
      vim.cmd('Neotree filesystem reveal left dir=' .. dir)
      vim.cmd 'wincmd l'

      local function ok(exe) return vim.fn.executable(exe) == 1 and 'OK' or 'MISSING' end

      local buf = vim.api.nvim_get_current_buf()
      local lines = {
        '',
        '███╗   ██╗██╗   ██╗██╗███╗   ███╗',
        '████╗  ██║██║   ██║██║████╗ ████║',
        '██╔██╗ ██║██║   ██║██║██╔████╔██║',
        '██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║',
        '██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║',
        '╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝',
        '',
        'error311.nvim',
        '',
        'Core tool check',
        '--------------',
        ('Neovim : %s'):format(tostring(vim.version())),
        ('git    : %s'):format(ok 'git'),
        ('make   : %s'):format(ok 'make'),
        ('unzip  : %s'):format(ok 'unzip'),
        ('rg     : %s'):format(ok 'rg'),
        ('fd     : %s'):format(ok 'fd'),
        ('tmux   : %s'):format(ok 'tmux'),
        ('node   : %s'):format(ok 'node'),
        ('npm    : %s'):format(ok 'npm'),
        '',
        ('cwd    : %s'):format(vim.fn.fnamemodify(args.file, ':p')),
        '',
        'Keys',
        '----',
        '<leader>ch  checkhealth error311',
      }

      vim.api.nvim_buf_set_name(buf, 'error311://startup')
      vim.bo[buf].buftype = 'nofile'
      vim.bo[buf].bufhidden = 'wipe'
      vim.bo[buf].swapfile = false
      vim.bo[buf].modifiable = true
      vim.bo[buf].filetype = 'error311-start'
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      vim.bo[buf].modifiable = false
      vim.cmd 'wincmd h'
    end)
  end,
})
