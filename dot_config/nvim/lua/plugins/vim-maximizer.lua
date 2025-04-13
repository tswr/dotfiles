-- Maximizer lets you maximize split windows and restore them automatically.

return {
  "szw/vim-maximizer",
  keys = {
    { "<leader>wm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
  },
}
