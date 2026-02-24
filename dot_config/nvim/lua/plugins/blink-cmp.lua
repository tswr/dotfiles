local env = require("core.env")
local is_meta = env.is_meta_infra()
local is_fbsource = env.is_fbsource()

local default_sources = { "lsp", "snippets" }
local providers = {}

if is_fbsource then
  table.insert(default_sources, "metamate")
  providers.metamate = {
    name = "Metamate",
    module = "blink-metamate",
    async = true,
    score_offset = 100,
  }
end

if not is_meta then
  table.insert(default_sources, "copilot")
  providers.copilot = {
    name = "copilot",
    module = "blink-copilot",
    score_offset = 100,
    async = true,
    transform_items = function(_, items)
      for _, item in ipairs(items) do
        item.detail = nil
      end
      return items
    end,
  }
end

table.insert(default_sources, "buffer")
table.insert(default_sources, "path")

return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "fang2hou/blink-copilot",
      cond = function()
        return not require("core.env").is_meta_infra()
      end,
      opts = {
        max_completions = 3,
        max_attempts = 4,
      },
    },
  },
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
      default = default_sources,
      providers = providers,
    },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      ghost_text = {
        enabled = true,
        show_with_selection = true,
        show_without_selection = true,
        show_with_menu = true,
        show_without_menu = true,
      },
      menu = {
        direction_priority = { 'n', 's' },
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
