-- A completion engine plugin for neovim written in Lua

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",       -- source for text in buffer
    "hrsh7th/cmp-path",         -- source for file system paths
    "hrsh7th/cmp-nvim-lua",     -- source for nvim lua
    "hrsh7th/cmp-nvim-lsp",     -- source for neovim's built-in language server client.
    {
      "L3MON4D3/LuaSnip",
      dependencies = { "rafamadriz/friendly-snippets" },
      -- follow latest release.
      version = "v2.*",       -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip",     -- for autocompletion
    "onsails/lspkind.nvim",         -- vs-code like pictograms
  },
  config = function()
    local cmp = require("cmp")

    local luasnip = require("luasnip")
    vim.keymap.set({"i", "s"}, "<tab>", function()
      if luasnip.locally_jumpable() then
        luasnip.jump(1)
      else
        return "<tab>"
      end
    end, {silent = true, expr = true})
    vim.keymap.set({"i", "s"}, "<s-tab>", function()
      if luasnip.locally_jumpable() then
        luasnip.jump(-1)
      else
        return "<s-tab>"
      end
    end, {silent = true, expr = true})

    local lspkind = require("lspkind")

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noinsert",
      },
      snippet = {       -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),         -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        -- TODO: consider using max_item_count to limit number of
        -- completion
        { name = "nvim_lua" },                           -- is enabled only for lua by default
        { name = "nvim_lsp" },
        { name = "luasnip" },                            -- snippets
        { name = "buffer",  keyword_length = 5 },        -- text within current buffer
        { name = "path" },                               -- file system paths
      }),

      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = {
            -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            -- can also be a function to dynamically calculate max width such as
            -- menu = function() return math.floor(0.45 * vim.o.columns) end,
            menu = 50,                     -- leading text (labelDetails)
            abbr = 50,                     -- actual suggestion item
          },
          ellipsis_char = '...',           -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

          menu = ({
            nvim_lua = "[Lua]",
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
            buffer = "[Buf]",
            path = "[Path]",
          })
        }),
      },
    })
  end,
}
