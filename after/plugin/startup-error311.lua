local startup_ns = vim.api.nvim_create_namespace('error311-startup')

local function startup_mark(buf, row, col_start, col_end, group)
  vim.api.nvim_buf_set_extmark(buf, startup_ns, row, col_start, {
    end_col = col_end,
    hl_group = group,
    strict = false,
  })
end

local function startup_set_hl()
  vim.api.nvim_set_hl(0, 'Error311NvimLogo', { fg = '#D19A66', bold = true })
  vim.api.nvim_set_hl(0, 'Error311Logo', { fg = '#569CD6', bold = true })
  vim.api.nvim_set_hl(0, 'Error311Title', { fg = '#569CD6', bold = true })
  vim.api.nvim_set_hl(0, 'Error311Section', { fg = '#DCDCAA', bold = true })
  vim.api.nvim_set_hl(0, 'Error311Label', { fg = '#9CDCFE' })
  vim.api.nvim_set_hl(0, 'Error311Value', { fg = '#D4D4D4' })
  vim.api.nvim_set_hl(0, 'Error311Key', { fg = '#C586C0', bold = true })
  vim.api.nvim_set_hl(0, 'Error311Ok', { fg = '#73C991', bold = true })
  vim.api.nvim_set_hl(0, 'Error311Missing', { fg = '#F14C4C', bold = true })
  vim.api.nvim_set_hl(0, 'Error311Rule', { fg = '#3C3C3C' })
end

local function startup_version()
  local v = vim.version()
  return string.format('v%d.%d.%d', v.major, v.minor, v.patch)
end

local function exe_ok(exe)
  return vim.fn.executable(exe) == 1
end

local function status_text(exe)
  if exe_ok(exe) then
    return '󰄬 OK'
  end
  return '󰅙 MISSING'
end

local function detect_shell()
  local shell = vim.env.SHELL or ''
  if shell == '' then
    return 'unknown'
  end
  return vim.fn.fnamemodify(shell, ':t')
end

local function detect_wm()
  if vim.env.HYPRLAND_INSTANCE_SIGNATURE and vim.env.HYPRLAND_INSTANCE_SIGNATURE ~= '' then
    return 'Hyprland'
  end
  if vim.env.XDG_CURRENT_DESKTOP and vim.env.XDG_CURRENT_DESKTOP ~= '' then
    return vim.env.XDG_CURRENT_DESKTOP
  end
  if vim.env.DESKTOP_SESSION and vim.env.DESKTOP_SESSION ~= '' then
    return vim.env.DESKTOP_SESSION
  end
  return 'unknown'
end

local function git_branch(dir)
  if not exe_ok('git') then
    return nil
  end

  local out = vim.fn.systemlist({ 'git', '-C', dir, 'rev-parse', '--abbrev-ref', 'HEAD' })
  if vim.v.shell_error == 0 and out[1] and out[1] ~= '' and out[1] ~= 'HEAD' then
    return out[1]
  end

  return nil
end

local function lazy_plugin_count()
  local ok, lazy = pcall(require, 'lazy')
  if not ok then
    return 'unknown'
  end

  local ok_stats, stats = pcall(lazy.stats)
  if not ok_stats or type(stats) ~= 'table' then
    return 'unknown'
  end

  return tostring(stats.count or 'unknown')
end

local function pad_right(str, width)
  local display_width = vim.fn.strdisplaywidth(str)
  if display_width >= width then
    return str
  end
  return str .. string.rep(' ', width - display_width)
end

local function two_col(left, right, left_width)
  return pad_right(left or '', left_width) .. ' │ ' .. (right or '')
end

local function startup_mark_segment(buf, row, col_start, text)
  if not text or text == '' then
    return
  end

  local colon = text:find(':', 1, true)
  if colon then
    startup_mark(buf, row, col_start, col_start + colon, 'Error311Label')
    startup_mark(buf, row, col_start + colon, col_start + #text, 'Error311Value')
  else
    startup_mark(buf, row, col_start, col_start + #text, 'Error311Value')
  end

  local ok_pos = text:find('󰄬 OK', 1, true)
  if ok_pos then
    startup_mark(buf, row, col_start + ok_pos - 1, col_start + #text, 'Error311Ok')
  end

  local missing_pos = text:find('󰅙 MISSING', 1, true)
  if missing_pos then
    startup_mark(buf, row, col_start + missing_pos - 1, col_start + #text, 'Error311Missing')
  end
end

vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('error311-startup-directory', { clear = true }),
  callback = function(args)
    local dir

    if vim.fn.argc() == 0 then
      dir = vim.fn.getcwd()
    elseif vim.fn.argc() == 1 and vim.fn.isdirectory(args.file) == 1 then
      dir = vim.fn.fnamemodify(args.file, ':p')
    else
      return
    end

    local dir_escaped = vim.fn.fnameescape(dir)
    local uname = vim.uv.os_uname()
    local project = vim.fn.fnamemodify(dir:gsub('/$', ''), ':t')
    local branch = git_branch(dir)

    vim.schedule(function()
      startup_set_hl()

      vim.cmd('Neotree filesystem reveal left dir=' .. dir_escaped)
      vim.cmd('wincmd l')

      local buf = vim.api.nvim_get_current_buf()
      local win = vim.api.nvim_get_current_win()

      local previous_window_opts = {
        number = vim.api.nvim_get_option_value('number', { win = win }),
        relativenumber = vim.api.nvim_get_option_value('relativenumber', { win = win }),
        cursorline = vim.api.nvim_get_option_value('cursorline', { win = win }),
        signcolumn = vim.api.nvim_get_option_value('signcolumn', { win = win }),
        foldcolumn = vim.api.nvim_get_option_value('foldcolumn', { win = win }),
        wrap = vim.api.nvim_get_option_value('wrap', { win = win }),
      }

      local lines = {}

      local function add(line)
        table.insert(lines, line)
      end

      add('')
      add(
        '   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗'
      )
      add(
        '   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║'
      )
      add(
        '   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║'
      )
      add(
        '   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║'
      )
      add(
        '   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║'
      )
      add(
        '   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝'
      )
      add('')
      add(
        '███████╗██████╗ ██████╗  ██████╗ ██████╗ ██████╗  ██╗ ██╗'
      )
      add(
        '██╔════╝██╔══██╗██╔══██╗██╔═══██╗██╔══██╗╚════██╗███║███║'
      )
      add(
        '█████╗  ██████╔╝██████╔╝██║   ██║██████╔╝ █████╔╝╚██║╚██║'
      )
      add(
        '██╔══╝  ██╔══██╗██╔══██╗██║   ██║██╔══██╗ ╚═══██╗ ██║ ██║'
      )
      add(
        '███████╗██║  ██║██║  ██║╚██████╔╝██║  ██║██████╔╝ ██║ ██║'
      )
      add(
        '╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝  ╚═╝ ╚═╝'
      )
      add('')
      add(
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
      )
      add('System')
      add(string.format('Neovim   : %s', startup_version()))
      add(string.format('OS       : %s %s', uname.sysname, uname.release))
      add(string.format('Arch     : %s', uname.machine))
      add(string.format('WM       : %s', detect_wm()))
      add(string.format('Shell    : %s', detect_shell()))
      add(string.format('Host     : %s', vim.fn.hostname()))
      add(string.format('Project  : %s', project))
      add(string.format('Branch   : %s', branch or 'none'))
      add(string.format('CWD      : %s', dir))
      add('')
      local colw = 34

      local tools = {
        string.format('plugins      : %s', lazy_plugin_count()),
        string.format('git          : %s', status_text('git')),
        string.format('make         : %s', status_text('make')),
        string.format('unzip        : %s', status_text('unzip')),
        string.format('rg           : %s', status_text('rg')),
        string.format('fd           : %s', status_text('fd')),
        string.format('tmux         : %s', status_text('tmux')),
        string.format('node         : %s', status_text('node')),
        string.format('npm          : %s', status_text('npm')),
        string.format('stylua       : %s', status_text('stylua')),
        string.format('prettierd    : %s', status_text('prettierd')),
        string.format('clang-format : %s', status_text('clang-format')),
        string.format('php-cs-fixer : %s', status_text('php-cs-fixer')),
        string.format('markdownlint : %s', status_text('markdownlint')),
      }

      local hotkeys = {
        'gd / gD     : diff open / close',
        'gg / gc     : git status / commit',
        'gh / gH     : file / repo history',
        'grn / gra   : rename / code action',
        'grr / grd   : refs / defs',
        'gri / grt   : impl / type defs',
        'xx / xX     : diag / buf diag',
        'cs / cl     : symbols / lsp list',
        'xL / xQ     : loclist / qflist',
        's / S       : flash / treesitter',
        'r / R       : remote / ts search',
        'th          : inlay hints',
        'nm / nf     : minimap / focus',
        'nr          : minimap refresh',
      }

      add(two_col('Tools', 'Hotkeys', colw))
      for i = 1, math.max(#tools, #hotkeys) do
        add(two_col(tools[i], hotkeys[i], colw))
      end

      add(
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
      )
      vim.api.nvim_buf_set_name(buf, 'error311://startup')
      vim.bo[buf].buftype = 'nofile'
      vim.bo[buf].bufhidden = 'wipe'
      vim.bo[buf].swapfile = false
      vim.bo[buf].modifiable = true
      vim.bo[buf].filetype = 'error311-start'
      vim.bo[buf].buflisted = false

      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      vim.api.nvim_buf_clear_namespace(buf, startup_ns, 0, -1)

      for i, line in ipairs(lines) do
        local row = i - 1
        local sep = ' │ '
        local sep_col = line:find(sep, 1, true)

        if i >= 2 and i <= 7 then
          startup_mark(buf, row, 0, #line, 'Error311NvimLogo')
        elseif i >= 9 and i <= 14 then
          startup_mark(buf, row, 0, #line, 'Error311Logo')
        elseif i == 16 or i == 43 then
          startup_mark(buf, row, 0, #line, 'Error311Title')
        elseif sep_col then
          local left_text = line:sub(1, sep_col - 1):gsub('%s+$', '')
          local right_col = sep_col - 1 + #sep
          local right_text = line:sub(sep_col + #sep)

          startup_mark(buf, row, sep_col - 1, sep_col - 1 + #sep, 'Error311Rule')

          if left_text == 'Tools' and right_text == 'Hotkeys' then
            startup_mark(buf, row, 0, #left_text, 'Error311Section')
            startup_mark(buf, row, right_col, right_col + #right_text, 'Error311Section')
          else
            startup_mark_segment(buf, row, 0, left_text)
            startup_mark_segment(buf, row, right_col, right_text)
          end
        elseif line == 'System' or line == 'Health' then
          startup_mark(buf, row, 0, #line, 'Error311Section')
        elseif line:match('^━+$') then
          startup_mark(buf, row, 0, #line, 'Error311Rule')
        elseif line:find(':', 1, true) then
          local colon = line:find(':', 1, true)
          if colon then
            startup_mark(buf, row, 0, colon, 'Error311Label')
            startup_mark(buf, row, colon, #line, 'Error311Value')
          end

          local ok_pos = line:find('󰄬 OK', 1, true)
          if ok_pos then
            startup_mark(buf, row, ok_pos - 1, #line, 'Error311Ok')
          end

          local missing_pos = line:find('󰅙 MISSING', 1, true)
          if missing_pos then
            startup_mark(buf, row, missing_pos - 1, #line, 'Error311Missing')
          end
        end
      end

      vim.bo[buf].modifiable = false

      vim.api.nvim_set_option_value('number', false, { win = win })
      vim.api.nvim_set_option_value('relativenumber', false, { win = win })
      vim.api.nvim_set_option_value('cursorline', false, { win = win })
      vim.api.nvim_set_option_value('signcolumn', 'no', { win = win })
      vim.api.nvim_set_option_value('foldcolumn', '0', { win = win })
      vim.api.nvim_set_option_value('wrap', false, { win = win })

      vim.api.nvim_create_autocmd('BufWinLeave', {
        buffer = buf,
        once = true,
        callback = function()
          if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_set_option_value('number', previous_window_opts.number, { win = win })
            vim.api.nvim_set_option_value('relativenumber', previous_window_opts.relativenumber, { win = win })
            vim.api.nvim_set_option_value('cursorline', previous_window_opts.cursorline, { win = win })
            vim.api.nvim_set_option_value('signcolumn', previous_window_opts.signcolumn, { win = win })
            vim.api.nvim_set_option_value('foldcolumn', previous_window_opts.foldcolumn, { win = win })
            vim.api.nvim_set_option_value('wrap', previous_window_opts.wrap, { win = win })
          end
        end,
      })

      vim.cmd('wincmd h')
    end)
  end,
})
