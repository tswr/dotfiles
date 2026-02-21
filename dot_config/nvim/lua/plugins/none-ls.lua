-- Use Neovim as a language server to inject LSP diagnostics, code actions, and
-- more via Lua.
--
-- `null-ls.nvim` Reloaded, maintained by the community.
-- Only loaded in Meta (fbsource) environments.

if not string.find(vim.fn.expand(vim.fn.getcwd() or ""), "fbsource", 1, true) then
  return {}
end

return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local meta = require("meta")
    local sources = {
      meta.null_ls.diagnostics.arclint,
      meta.null_ls.formatting.arclint,
    }

    local on_attach = function(client, bufnr)
      if client.server_capabilities.documentFormattingProvider then
        vim.cmd([[
        augroup LspFormatting
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> silent noa w | lua vim.lsp.buf.format({async=false,timeout_ms=30000})
        augroup END
        ]])
      end
    end

    null_ls.setup({
      on_attach = on_attach,
      sources = sources,
    })
  end,
}
