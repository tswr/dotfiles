return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  opts = {
    indent = { char = "│", tab_char = "│" },
    scope = { enabled = true, show_start = false, show_end = false },
    exclude = {
      filetypes = { "help", "alpha", "NvimTree", "Trouble", "trouble", "lazy", "mason" },
    },
  },
}
