if require("core.env").is_fbsource() then
  return {
    dir = "~/fbsource/fbcode/editor_support/nvim/",
    name = "meta.nvim",
    event = "BufRead",
    config = function()
      local keymap = vim.keymap

      -- Hg keymaps
      keymap.set("n", "<leader>mb", "<cmd>HgBlame<CR>", { desc = "Hg blame" })
      keymap.set("n", "<leader>mc", "<cmd>HgBrowse<CR>", { desc = "Open in CodeHub" })
      keymap.set("n", "<leader>md", "<cmd>HgDiffIgnoreAllSpace<CR>", { desc = "Hg diff" })
      keymap.set("n", "<leader>mh", "<cmd>HgHistory<CR>", { desc = "Hg history" })
      keymap.set("n", "<leader>mS", "<cmd>HgSsl<CR>", { desc = "Hg ssl" })
      keymap.set("n", "<leader>ma", "<cmd>HgAmend<CR>", { desc = "Hg amend" })
      keymap.set("n", "<leader>mC", "<cmd>HgCommit<CR>", { desc = "Hg commit" })
      keymap.set("n", "<leader>mt", "<cmd>HgStatus<CR>", { desc = "Hg status" })

      -- BigGrep keymaps
      keymap.set("n", "<leader>ms", "<cmd>Bgs<CR>", { desc = "BigGrep substring" })
      keymap.set("v", "<leader>ms", ":<C-u>'<,'>Bgs<CR>", { desc = "BigGrep selection" })
      keymap.set("n", "<leader>mr", "<cmd>Bgr<CR>", { desc = "BigGrep regex" })
      keymap.set("n", "<leader>mn", "<cmd>Bgf<CR>", { desc = "BigGrep filename" })

      -- Jump to BUCK file picker
      keymap.set("n", "<leader>mB", function()
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local path = vim.api.nvim_buf_get_name(0)
        pickers
            .new({}, {
              prompt_title = "Jump to BUCK",
              finder = finders.new_oneshot_job({ "buck", "query", "buildfile(owner(" .. path .. "))" }),
              sorter = conf.generic_sorter({}),
              previewer = conf.cat_previewer,
            })
            :find()
      end, { desc = "Jump to BUCK" })

      require("meta").setup({
        buck = {
          keybindings = {
            enabled = true,
          },
        },
      })

      -- Start code-compose LSP for blink-metamate source (no inline ghost text)
      local cc_cmd = require("meta.metamate")._get_code_compose_cmd()
      if cc_cmd then
        local metamate_filetypes = {
          "bash", "buck", "c", "chef", "cpp", "css", "gitcommit", "go",
          "hack", "hgcommit", "javascript", "javascriptreact", "json",
          "jsonc", "lua", "markdown", "mdx", "php", "python", "rust",
          "sh", "sql", "typescript", "typescriptreact", "zsh",
        }
        vim.lsp.config("code-compose", {
          cmd = cc_cmd,
          filetypes = metamate_filetypes,
        })
        vim.lsp.enable("code-compose")
      end

      keymap.set("n", "<leader>mf", vim.lsp.buf.format, {})

      vim.opt.makeprg =
      "/home/tswr/fbsource/arvr/projects/mixedreality/scripts/mr_build_and_deploy_mrservice.sh --device fiji --no-deploy"
      vim.opt.errorformat = "%f:%l:%c: %t%*[^:]: %m"
    end,
  }
else
  return {}
end
