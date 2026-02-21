-- **WhichKey** helps you remember your Neovim keymaps, by showing available keybindings in a popup as you type.

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    spec = {
      {
        mode = { "n", "v" },
        { "<leader>a", group = "ai" },
        { "<leader>d", group = "debug" },
        { "<leader>e", group = "nvim tree" },
        { "<leader>f", group = "find" },
        { "<leader>m", group = "meta" },
        { "<leader>g", group = "git" },
        { "<leader>gh", group = "hunk" },
        { "<leader>gt", group = "toggle" },
        { "<leader>w", group = "window" },
        { "<leader>l", group = "lsp" },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "gs", group = "surround" },
        { "gc", group = "comment" },
        { "z", group = "fold" },
      },
    },
  },
}
