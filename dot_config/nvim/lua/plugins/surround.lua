-- A plugin for adding/deleting/changing delimiter pairs.

return {
  "kylechui/nvim-surround",
  event = { "BufReadPre", "BufNewFile" },
  version = "*",   -- Use for stability; omit to use `main` branch for the latest features
  config = true,
}
