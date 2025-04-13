require("core")
if vim.g.vscode then
  -- Don't load plugins when running with vscode
else
  require("config.lazy")
end
