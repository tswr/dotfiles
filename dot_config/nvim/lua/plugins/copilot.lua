return {
  "zbirenbaum/copilot.lua",
  cond = function()
    return not require("core.env").is_meta_infra()
  end,
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    suggestion = { enabled = false },
    panel = { enabled = false },
    filetypes = {
      gitcommit = false,
      gitrebase = false,
      ["."] = true,
    },
  },
}
