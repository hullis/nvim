-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

map('i', 'jj', '<esc>', opt)

-- nvim tree
map('n', '<C-n>', ':NvimTreeToggle<CR>', opt)
map('n', '<leader>rt', ':NvimTreeFindFile<CR>', opt) -- reveal in tree

-- buffer
map('n', 'gt', ':BufferLineCycleNext<CR>', opt)
map('n', '<tab>', ':BufferLineCycleNext<CR>', opt)
map('n', 'gT', ':BufferLineCyclePrev<CR>', opt)
map('n', '<S-tab>', ':BufferLineCyclePrev<CR>', opt)
map('n', '<leader>q', '<cmd>bd<CR>', opt)
map('n', '<leader>w', '<cmd>w<CR>', opt)
map('n', '<leader>s', '<cmd>w<CR>', opt)

-- editor
map('n', '<leader>aq', '<cmd>q<CR>', opt)

-- telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opt)
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opt)
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opt)
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', opt)

local M = {}

M.maplsp = function(mapbuf)
  mapbuf('n', '<leader>rs', '<cmd>lua vim.lsp.buf.rename()<CR>', opt)
  mapbuf('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opt)
  mapbuf('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opt)
  mapbuf('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opt)
end

M.cmp = function(cmp)
  return {
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<A-.>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<A-,>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({
      select = true ,
      behavior = cmp.ConfirmBehavior.Replace
    }),
    -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  }
end

return M
