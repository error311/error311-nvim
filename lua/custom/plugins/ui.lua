return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'quarto' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      file_types = { 'markdown', 'quarto' },
      heading = {
        position = 'inline',
        width = 'block',
      },
      code = {
        width = 'block',
        right_pad = 1,
      },
      checkbox = {
        enabled = true,
      },
      bullet = {
        enabled = true,
      },
    },
  },

  {
    'iamcco/markdown-preview.nvim',
    ft = { 'markdown' },
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = function()
      require('lazy').load { plugins = { 'markdown-preview.nvim' } }
      vim.fn['mkdp#util#install']()
    end,
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_theme = 'dark'
      vim.cmd [[do FileType]]
    end,
  },

  {
    'Mofiqul/vscode.nvim',
    priority = 1000,
    config = function()
      local c = require('vscode.colors').get_colors()
      require('vscode').setup {
        transparent = false,
        italic_comments = true,
        italic_inlayhints = true,
        underline_links = true,
        disable_nvimtree_bg = false,
        terminal_colors = true,
        group_overrides = {
          Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
        },
      }
      vim.cmd.colorscheme 'vscode'
    end,
  },

  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },
      win = {
        border = 'single',
      },
      spec = {
        { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>g', group = '[G]it' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { 'gr', group = 'LSP Actions', mode = { 'n' } },
      },
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          prompt_prefix = '   ',
          selection_caret = '  ',
          entry_prefix = '  ',
          initial_mode = 'insert',
          sorting_strategy = 'ascending',
          layout_strategy = 'horizontal',
          layout_config = {
            prompt_position = 'top',
            horizontal = {
              width = 0.92,
              height = 0.86,
              preview_width = 0.56,
            },
            vertical = {
              width = 0.92,
              height = 0.90,
              preview_height = 0.52,
            },
          },
          border = true,
          borderchars = {
            prompt = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
            results = { '│', ' ', '│', '│', '╰', '─', '╯', '│' },
            preview = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
          },
          winblend = 0,
          path_display = { 'smart' },
        },
        pickers = {
          find_files = { hidden = true },
          live_grep = {
            additional_args = function()
              return { '--hidden' }
            end,
          },
          buffers = {
            sort_mru = true,
            ignore_current_buffer = true,
          },
        },
        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown() },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'

      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
      vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = 'Fuzzy search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
        callback = function(event)
          local buf = event.buf
          vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })
          vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })
          vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })
          vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })
          vim.keymap.set(
            'n',
            'gW',
            builtin.lsp_dynamic_workspace_symbols,
            { buffer = buf, desc = 'Open Workspace Symbols' }
          )
          vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
        end,
      })
    end,
  },

  {
    '3rd/image.nvim',
    event = 'VeryLazy',
    opts = {
      backend = 'kitty',
      processor = 'magick_cli',
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          floating_windows = false,
          filetypes = { 'markdown', 'vimwiki' },
        },
      },

      max_width = nil,
      max_height = nil,
      max_width_window_percentage = 100,
      max_height_window_percentage = 100,
      scale_factor = 1.0,

      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
      hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif' },
    },
  },

  {
    'Isrothy/neominimap.nvim',
    version = 'v3.x.x',
    lazy = false,
    keys = {
      { '<leader>nm', '<cmd>Neominimap Toggle<cr>', desc = 'Toggle minimap' },
      { '<leader>nf', '<cmd>Neominimap ToggleFocus<cr>', desc = 'Toggle minimap focus' },
      { '<leader>nr', '<cmd>Neominimap Refresh<cr>', desc = 'Refresh minimap' },
    },
    init = function()
      vim.opt.wrap = false
      vim.opt.sidescrolloff = 36

      vim.g.neominimap = {
        auto_enable = true,
        layout = 'split',
        split = {
          minimap_width = 16,
          direction = 'right',
        },

        diagnostic = { enabled = true },
        git = { enabled = true },
        search = { enabled = true },
        mark = { enabled = true },

        click = {
          enabled = true,
          auto_switch_focus = false,
        },
      }
    end,
  },
}
