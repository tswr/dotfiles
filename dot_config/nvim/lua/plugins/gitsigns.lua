return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
    current_line_blame = false,
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end
      -- Navigation
      map("n", "]h", gs.next_hunk, "Next hunk")
      map("n", "[h", gs.prev_hunk, "Previous hunk")
      -- Hunk actions
      map("n", "<leader>ghs", gs.stage_hunk, "Stage hunk")
      map("n", "<leader>ghr", gs.reset_hunk, "Reset hunk")
      map("v", "<leader>ghs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Stage hunk")
      map("v", "<leader>ghr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Reset hunk")
      map("n", "<leader>ghS", gs.stage_buffer, "Stage buffer")
      map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo stage hunk")
      map("n", "<leader>ghR", gs.reset_buffer, "Reset buffer")
      map("n", "<leader>ghp", gs.preview_hunk, "Preview hunk")
      map("n", "<leader>ghd", gs.diffthis, "Diff this")
      map("n", "<leader>ghD", function()
        gs.diffthis("~")
      end, "Diff against ~")
      -- Blame
      map("n", "<leader>gB", function()
        gs.blame_line({ full = true })
      end, "Blame line")
      map("n", "<leader>gtb", gs.toggle_current_line_blame, "Toggle blame")
      map("n", "<leader>gtd", gs.toggle_deleted, "Toggle deleted")
    end,
  },
}
