-- **WhichKey** helps you remember your Neovim keymaps, by showing available keybindings in a popup as you type.

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    spec = {
      {
        mode = { "n", "v" },
        { "<leader>e", group = "nvim tree" },
        { "<leader>f", group = "find" },
        { "<leader>m", group = "meta" },
        { "<leader>g", group = "git" },
        { "<leader>w", group = "window" },
        { "<leader>l", group = "lsp" },
        { "[",         group = "prev" },
        { "]",         group = "next" },
        { "g",         group = "goto" },
        { "gs",        group = "surround" },
        { "gc",        group = "comment" },
        { "z",         group = "fold" },
      }
    },
  },
}
