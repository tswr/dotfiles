-- Nvim integrates the `tree-sitter` library for incremental parsing of buffers: https://tree-sitter.github.io/tree-sitter/

return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    { "windwp/nvim-ts-autotag", opts = {} },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      config = function()
        local select = require("nvim-treesitter.textobjects.select")
        local move = require("nvim-treesitter.textobjects.move")

        require("nvim-treesitter.configs").setup({ textobjects = {
          select = {
            enable = true,
            lookahead = true,
            selection_modes = {
              ["@parameter.outer"] = "v",
              ["@function.outer"] = "V",
              ["@class.outer"] = "<c-v>",
            },
            include_surrounding_whitespace = true,
          },
          move = {
            enable = true,
            set_jumps = true,
          },
        }})

        -- Select keymaps
        local select_maps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["as"] = "@local.scope",
        }
        for key, query in pairs(select_maps) do
          vim.keymap.set({ "x", "o" }, key, function()
            select.select_textobject(query)
          end, { desc = "Select " .. query })
        end

        -- Move keymaps
        vim.keymap.set({ "n", "x", "o" }, "]m", function() move.goto_next_start("@function.outer") end, { desc = "Next function start" })
        vim.keymap.set({ "n", "x", "o" }, "]M", function() move.goto_next_end("@function.outer") end, { desc = "Next function end" })
        vim.keymap.set({ "n", "x", "o" }, "]]", function() move.goto_next_start("@class.outer") end, { desc = "Next class start" })
        vim.keymap.set({ "n", "x", "o" }, "][", function() move.goto_next_end("@class.outer") end, { desc = "Next class end" })
        vim.keymap.set({ "n", "x", "o" }, "]o", function() move.goto_next_start("@loop.outer") end, { desc = "Next loop" })
        vim.keymap.set({ "n", "x", "o" }, "]d", function() move.goto_next("@conditional.outer") end, { desc = "Next conditional" })

        vim.keymap.set({ "n", "x", "o" }, "[m", function() move.goto_previous_start("@function.outer") end, { desc = "Prev function start" })
        vim.keymap.set({ "n", "x", "o" }, "[M", function() move.goto_previous_end("@function.outer") end, { desc = "Prev function end" })
        vim.keymap.set({ "n", "x", "o" }, "[[", function() move.goto_previous_start("@class.outer") end, { desc = "Prev class start" })
        vim.keymap.set({ "n", "x", "o" }, "[]", function() move.goto_previous_end("@class.outer") end, { desc = "Prev class end" })
        vim.keymap.set({ "n", "x", "o" }, "[d", function() move.goto_previous("@conditional.outer") end, { desc = "Prev conditional" })
      end,
    },
  },
  config = function()
    require("nvim-treesitter").setup()

    -- Enable treesitter highlighting for all buffers
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })

    -- Incremental selection
    vim.keymap.set("n", "gnn", function()
      require("nvim-treesitter.incremental_selection").init_selection()
    end, { desc = "Init treesitter selection" })
    vim.keymap.set("x", "grn", function()
      require("nvim-treesitter.incremental_selection").node_incremental()
    end, { desc = "Increment node selection" })
    vim.keymap.set("x", "grc", function()
      require("nvim-treesitter.incremental_selection").scope_incremental()
    end, { desc = "Increment scope selection" })
    vim.keymap.set("x", "grm", function()
      require("nvim-treesitter.incremental_selection").node_decremental()
    end, { desc = "Decrement node selection" })
  end,
}
