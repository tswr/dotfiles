-- A blazing fast and easy to configure Neovim statusline written in Lua.

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")
    local colors = {
      color0 = "#191919",
      color1 = "#f3005f",
      color2 = "#97e023",
      color3 = "#fa8419",
      color4 = "#9c64fe",
      color5 = "#f3005f",
      color6 = "#57d1ea",
      color7 = "#c4c4b5",
      color8 = "#615e4b",
    }

    local monokai_soda_theme = {
      normal = {
        a = { fg = colors.color0, bg = colors.color4, gui = "bold" },
        b = { fg = colors.color0, bg = colors.color2 },
        c = { fg = colors.color2, bg = colors.color0 },
      },
      insert = { a = { fg = colors.color0, bg = colors.color6, gui = "bold" } },
      visual = { a = { fg = colors.color0, bg = colors.color3, gui = "bold" } },
      replace = { a = { fg = colors.color0, bg = colors.color1, gui = "bold" } },
      inactive = {
        a = { fg = colors.color5, bg = colors.color0, gui = "bold" },
        b = { fg = colors.color7, bg = colors.color5 },
        c = { fg = colors.color8, bg = colors.color0 },
      },
    }
    lualine.setup({
      options = {
        icons_enabled = false,
        theme = monokai_soda_theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "diff", "diagnostics", "filename" },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    })
  end,
}
