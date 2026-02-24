-- Installed as a dependency for meta.nvim (meta.setup() registers its own null-ls sources).
-- linttool@meta handles linting/formatting; no custom sources needed here.
if not require("core.env").is_fbsource() then
  return {}
end

return {
  "nvimtools/none-ls.nvim",
}
