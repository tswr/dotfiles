-- GitHub Copilot - Your AI pair programmer

local hostname = vim.fn.system("hostname"):gsub("\n", "")

if hostname == "tswr-desktop-linux" then
  return {
    "github/copilot.vim",
  }
else
  return {}
end
