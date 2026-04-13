return {
  {
    'NMAC427/guess-indent.nvim',
    opts = {},
  },

  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  {
    'nvim-mini/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      statusline.section_location = function() return '%2l:%-2v' end
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    config = function()
      local parsers = {
        'bash',
        'c',
        'cpp',
        'css',
        'diff',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'jsonc',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'php',
        'query',
        'regex',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'yaml',
      }

      require('nvim-treesitter').install(parsers)

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf = args.buf
          local filetype = args.match
          local language = vim.treesitter.language.get_lang(filetype)
          if not language then return end
          if not vim.treesitter.language.add(language) then return end

          vim.treesitter.start(buf, language)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },
}
