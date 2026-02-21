return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = { "rafamadriz/friendly-snippets" },
  event = "InsertEnter",
  opts = {
    keymap = {
      preset = "default",
      ["<C-b>"] = { "scroll_documentation_up" },
      ["<C-f>"] = { "scroll_documentation_down" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-Space>"] = { "show" },
      ["<C-e>"] = { "cancel" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },
    sources = {
      default = { "lsp", "snippets", "buffer", "path" },
    },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      menu = {
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "source_name" },
          },
        },
      },
    },
    appearance = { nerd_font_variant = "mono" },
  },
}
