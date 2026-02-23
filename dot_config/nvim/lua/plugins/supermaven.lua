return {
  "supermaven-inc/supermaven-nvim",
  cond = function() return not require("core.env").is_meta_infra() end,
  event = "InsertEnter",
  opts = {
    keymaps = {
      accept_suggestion = "<Tab>",
      clear_suggestion = "<C-]>",
      accept_word = "<C-j>",
    },
    log_level = "off",
  },
}
