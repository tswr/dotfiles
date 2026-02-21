return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diffview open" },
    { "<leader>gD", "<cmd>DiffviewOpen HEAD~1<CR>", desc = "Diff last commit" },
    { "<leader>gf", "<cmd>DiffviewFileHistory %<CR>", desc = "File history" },
    { "<leader>gF", "<cmd>DiffviewFileHistory<CR>", desc = "Repo history" },
    { "<leader>gq", "<cmd>DiffviewClose<CR>", desc = "Close diffview" },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = { layout = "diff2_horizontal" },
      merge_tool = { layout = "diff3_horizontal" },
    },
  },
}
