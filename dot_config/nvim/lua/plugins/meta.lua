if string.find(vim.fn.expand(vim.fn.getcwd() or ""), "fbsource", 0) then
  return {
    dir = "~/fbsource/fbcode/editor_support/nvim/",
    name = "meta.nvim",
    event = "BufRead",
    config = function()
      require("meta.hg").setup()

      local keymap = vim.keymap
      keymap.set("n", "<leader>mb", "<cmd>HgBlame<CR>", { desc = "Show blame" })
      keymap.set("n", "<leader>mc", "<cmd>HgBrowse<CR>", { desc = "Open in CodeHub" })
      keymap.set("n", "<leader>md", "<cmd>HgDiffIgnoreAllSpace<CR>", { desc = "Show diff" })
      keymap.set("n", "<leader>mh", "<cmd>HgHistory<CR>", { desc = "Show history" })
      keymap.set("n", "<leader>ms", "<cmd>HgSsl<CR>", { desc = "Show ssl" })

      require("meta").setup({})
      require("meta.metamate").init()

      keymap.set("n", "<leader>mf", vim.lsp.buf.format, {})

      vim.opt.makeprg =
      "/home/tswr/fbsource/arvr/projects/mixedreality/scripts/mr_build_and_deploy_mrservice.sh --device fiji --no-deploy"
      vim.opt.errorformat = "%f:%l:%c: %t%*[^:]: %m"
    end,
  }
else
  return {}
end
