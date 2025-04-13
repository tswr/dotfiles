-- Monokai Theme for Neovim with tree-sitter support

return {
  "tanvirtin/monokai.nvim",
  lazy = false,
  priority = 1000,   -- ensure this plugin loads first
  config = function()
    local monokai = require("monokai")
    monokai.setup({ palette = monokai.soda })
    vim.cmd("colorscheme monokai")
  end,
}
