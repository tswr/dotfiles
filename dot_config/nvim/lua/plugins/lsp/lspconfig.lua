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
        }
      }
    },
  },
  config = function()
    require("lspconfig").lua_ls.setup({})

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { buffer = args.buf, desc = "Rename" })
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { buffer = args.buf, desc = "Code action" })
        vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { buffer = args.buf, desc = "Hover" })
        vim.keymap.set("n", "<leader>lH", vim.lsp.buf.signature_help, { buffer = args.buf, desc = "Signature help" })

        if client.supports_method("textDocument/implementation") then
          -- Create a keymap for vim.lsp.buf.implementation
        end
        if client.supports_method("textDocument/formatting") then
          -- Format the current buffer on save
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
            end,
          })
        end
      end,
    })

    if string.find(vim.fn.expand(vim.fn.getcwd() or ""), "fbsource", 0) then
      local meta = require("meta.lsp")
      require("meta").setup({})
      local servers = {
        -- "pyls@meta", "pyre@meta",
        "cppls@meta",
        "thriftlsp@meta",
        "buck2@meta",
      }
      for _, lsp in ipairs(servers) do
        require("lspconfig")[lsp].setup {
          on_attach = on_attach,
        }
      end
    else
      require("lspconfig").clangd.setup({})
    end
  end
}
