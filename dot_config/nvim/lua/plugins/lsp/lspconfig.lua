return {
  "neovim/nvim-lspconfig",
  event = { "BufRead", "BufNewFile" },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "nvimtools/none-ls.nvim",
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  config = function()
    -- LspAttach keymaps
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, { buffer = args.buf, desc = "Rename" })
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { buffer = args.buf, desc = "Code action" })
        vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { buffer = args.buf, desc = "Hover" })
        vim.keymap.set("n", "<leader>lH", vim.lsp.buf.signature_help, { buffer = args.buf, desc = "Signature help" })
        -- Format-on-save handled by conform.nvim (outside Meta) or none-ls (inside Meta)
      end,
    })

    if string.find(vim.fn.expand(vim.fn.getcwd() or ""), "fbsource", 0) then
      local meta = require("meta.lsp")
      require("meta").setup({})
      local servers = {
        "cppls@meta",
        "thriftlsp@meta",
        "buck2@meta",
      }
      for _, lsp in ipairs(servers) do
        vim.lsp.config(lsp, {})
        vim.lsp.enable(lsp)
      end
    else
      -- Configure rust-analyzer with custom settings
      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            check = { command = "clippy", allTargets = true },
            cargo = { allFeatures = true },
          },
        },
      })

      -- Enable all servers (nvim-lspconfig provides default configs in lsp/ dir)
      vim.lsp.enable({
        "lua_ls",
        "clangd",
        "basedpyright",
        "rust_analyzer",
        "ts_ls",
        "cssls",
        "html",
        "emmet_ls",
      })
    end
  end,
}
