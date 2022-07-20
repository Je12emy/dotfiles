-- luasnip setup
local luasnip = require 'luasnip'
require("luasnip/loaders/from_vscode").lazy_load()

local cmp = require'cmp'
  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ['<C-y>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = 'path' },
      { name = 'conventionalcommits' },
      { name = 'nvim_lua' }
    },
    formatting = {
      format = function(entry, vim_item)
        -- fancy icons and a name of kind
        vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

        -- set a name for each source
        vim_item.menu = ({
          conventionalcommits = "[CC]",
          luasnip   = "[SNIP]",
          nvim_lsp  = "[LSP]",
          buffer    = "[BUFF]",
          nvim_lua  = "[NVIM]",
        })[entry.source.name]

        return vim_item
      end,
    },
  })
