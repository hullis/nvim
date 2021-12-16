local lsp_installer = require 'nvim-lsp-installer'

-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
  sumneko_lua = require 'lsp.lua',
  tsserver = false,
  html = false,
  cssls = false,
  jsonls = false
}

for name, _ in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      server:install()
    end
  end
end

lsp_installer.on_server_ready(function(server)
  local opts = servers[server.name] or {}

  opts.on_attach = function(_, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    require('keymappings').maplsp(buf_set_keymap)
  end

  opts.flags = {
    debounce_text_changes = 150,
  }

  server:setup(opts)
end)

-- local lsplinkd = require('lspkind')
local cmp = require('cmp')

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  }),
  mapping = require('keymappings').cmp(cmp)
}

