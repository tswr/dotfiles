-- Use Neovim as a language server to inject LSP diagnostics, code actions, and
-- more via Lua.
--
-- `null-ls.nvim` Reloaded, maintained by the community.

return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local sources = {
      -- null_ls.builtins.formatting.stylua,
    }
    local on_attach
    if string.find(vim.fn.expand(vim.fn.getcwd() or ""), "fbsource", 0) then
      local meta = require("meta")
      table.insert(sources, meta.null_ls.diagnostics.arclint)
      table.insert(sources, meta.null_ls.formatting.arclint)

      on_attach = function(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
          vim.cmd([[
          augroup LspFormatting
          autocmd! * <buffer>
          autocmd BufWritePre <buffer> silent noa w | lua vim.lsp.buf.format({async=false,timeout_ms=30000})
          augroup END
          ]])
        end
      end
    end

    null_ls.setup({
      on_attach = on_attach,
      sources = sources,
    })

  end,
}
