-- To define a mapping which uses the "g:mapleader" variable, the special string
-- "<Leader>" can be used.  It is replaced with the string value of
-- "g:mapleader".
vim.g.mapleader = " "

local keymap = vim.keymap

-- Incement / decrement numbers under cursor
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Splits
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>wn", "<C-w>n", { desc = "Split window horizontally" })
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>wq", "<cmd>close<CR>", { desc = "Close current split" })

-- Enhanced ^
keymap.set("n", "^", function()
  local col = vim.fn.col(".")
  if col == 1 then
    vim.cmd([[normal! ^]])
  else
    vim.cmd([[normal! 0]])
  end
end, { noremap = true })
