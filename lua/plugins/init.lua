-- pre require settings
vim.g.nvim_tree_show_icons = {
  files = 0,
  folders = 1,
  folder_arrows = 1,
  git = 0,
}
vim.g.nvim_tree_icons = {
  folder = {
    default = 'F',
    open = 'F',
    empty = 'E',
    empty_open = 'E',
    arrow_open = ".",
    arrow_closed = '>'
  }
}
vim.g.nvim_tree_quit_on_open = 1

require("packer").startup(function()
  -- package manager Packer
  -- https://github.com/wbthomason/packer.nvim
  use "wbthomason/packer.nvim"

  -- dracula theme
  -- https://github.com/Mofiqul/dracula.nvim
  use "Mofiqul/dracula.nvim"
  -- vim.cmd[[colorscheme dracula]] -- enable the plugin

  -- nvim tree
  -- https://github.com/kyazdani42/nvim-tree.lua
  use {
    "kyazdani42/nvim-tree.lua"
    -- I don't use icons
    -- requires = "kyazdani42/nvim-web-devicons"
  }

  -- bufferline
  -- https://github.com/akinsho/bufferline.nvim#close-icons
  use {
    'akinsho/bufferline.nvim'
  }

  -- statusline
  use {
    'nvim-lualine/lualine.nvim'
  }

  -- tree sitter
  use {
    'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'
  }

  -- lsp
  use {
    'neovim/nvim-lspconfig', 'williamboman/nvim-lsp-installer'
  }

  use {
    'tami5/lspsaga.nvim'
  }

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'rafamadriz/friendly-snippets'
  use 'onsails/lspkind-nvim'

  -- telescope
  use {
   'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' }
    }
  }
  
  -- git blame
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
  }
 end)

require("nvim-tree").setup {
  auto_close = true,
  git = {
    enable = true
  },
}

vim.opt.termguicolors = true 
require('bufferline').setup {
  options = {
    buffer_close_icon = 'x',
    modified_icon = 'o',
    close_icon = 'x',
    diagnostics = 'nvim_lsp',
    offsets = {{
      filetype = 'NvimTree'
    }}
  }
}

require('nvim-treesitter.configs').setup {
  ensure_installed = { "html", "css", "vim", "lua", "javascript", "typescript", "tsx" },
  highlight = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<CR>',
      node_decremental = '<BS>',
      scope_incremental = '<tab>',
    }
  },
}

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldlevel = 20

require('telescope').setup {
  file_ignore_patterns = { "node_modules" }
}

-- lualine
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {
      {
        'filename',
        path = 1
      }
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

require('gitsigns').setup {
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    delay = 1000,
  }
}

-- change gitlens color
vim.cmd[[highlight link GitSignsCurrentLineBlame Comment]]
