-- error311 config

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.modeline = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.pumborder = 'single'
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus left' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus right' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus down' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus up' })

vim.keymap.set('n', '<Esc><Esc>', '<Cmd>Neotree focus filesystem left<CR>', {
  desc = 'Focus Neo-tree',
  silent = true,
})

vim.keymap.set('n', '<leader>wf', '<cmd>Wayfinder<cr>', { desc = 'Wayfinder' })
vim.keymap.set('n', '<leader>wtn', '<Plug>(WayfinderTrailNext)', { desc = 'Wayfinder Trail Next' })
vim.keymap.set('n', '<leader>wtp', '<Plug>(WayfinderTrailPrev)', { desc = 'Wayfinder Trail Prev' })
vim.keymap.set('n', '<leader>wto', '<Plug>(WayfinderTrailOpen)', { desc = 'Wayfinder Trail Open' })
vim.keymap.set('n', '<leader>wts', '<Plug>(WayfinderTrailShow)', { desc = 'Wayfinder Trail Show' })

vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  virtual_text = true,
  virtual_lines = false,
  jump = { float = true },
}

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = vim.api.nvim_create_augroup('error311-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { import = 'custom.plugins' },
}, {
  ui = {
    size = { width = 0.88, height = 0.90 },
    wrap = false,
    border = 'single',
    backdrop = 90,
    title = ' Lazy ',
    title_pos = 'center',
    pills = true,
    throttle = 1000 / 60,
    icons = vim.g.have_nerd_font and {} or {
      cmd = ' ',
      config = '',
      event = ' ',
      favorite = ' ',
      ft = ' ',
      init = ' ',
      import = ' ',
      keys = ' ',
      lazy = '󰒲 ',
      loaded = '●',
      not_loaded = '○',
      plugin = ' ',
      runtime = ' ',
      require = '󰢱 ',
      source = ' ',
      start = ' ',
      task = '✔ ',
      list = { '●', '➜', '★', '‒' },
    },
  },
})
