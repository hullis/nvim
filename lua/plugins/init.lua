require("packer").startup(function()
  -- package manager Packer
  -- https://github.com/wbthomason/packer.nvim
  use "wbthomason/packer.nvim"

  -- dracula theme
  -- https://github.com/Mofiqul/dracula.nvim
  use "Mofiqul/dracula.nvim"
  vim.cmd[[colorscheme dracula]] -- enable the plugin

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

  -- tree sitter
  use {
    'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'
  }

  -- lsp
  use {
    'neovim/nvim-lspconfig', 'williamboman/nvim-lsp-installer'
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'   -- { name = 'buffer' },
  use 'hrsh7th/cmp-path'     -- { name = 'path' }
  use 'hrsh7th/cmp-cmdline'  -- { name = 'cmdline' }
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'    -- { name = 'vsnip' }
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

  -- TODO: add statusline plugin
 end)

-- TODO: move these to separate files
require("nvim-tree").setup {
  auto_close = true,
  git = {
    enable = true
  },
  icon = false
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
  }, -- indent = {
  --  enable = true,
  -- }
}

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldlevel = 20

require('telescope').setup {
  file_ignore_patterns = { "node_modules" }
}
