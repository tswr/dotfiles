return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "clangd",
        "lua_ls",
        "rust_analyzer",
        "basedpyright",
        "ts_ls",
        "cssls",
        "html",
        "emmet_ls",
      },
    })
    require("mason-tool-installer").setup({
      ensure_installed = {
        -- Formatters
        "stylua",
        "prettierd",
        "clang-format",
        "ruff",
        -- Linters
        "eslint_d",
        -- DAP adapters
        "debugpy",
        "codelldb",
      },
    })
  end,
}
