-- Telescope.nvim is a plugin for fuzzy finding and neovim. It helps you search,
-- filter, find and pick things in Lua.

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-h>"] = "which_key",
          },
        },
      },
      extensions = {
        fzf = {}
      }
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local builtin = require("telescope.builtin")
    local utils = require("telescope.utils")

    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
    vim.keymap.set("n", "<leader>fF", function()
      builtin.find_files({ cwd = utils.buffer_dir() })
    end, { desc = "Telescope find files in cwd" })
    vim.keymap.set("n", "<leader>f~", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "Telescope find files in config" })

    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
    vim.keymap.set("n", "<leader>fG", function()
      builtin.live_grep({ cwd = utils.buffer_dir() })
    end, { desc = "Telescope live grep in cwd" })

    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

    vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Telescope oldfiles" })
    vim.keymap.set("n", "<leader>fO", function()
      builtin.oldfiles({ cwd = utils.buffer_dir() })
    end, { desc = "Telescope oldfiles in cwd" })

    vim.keymap.set("n", '<leader>f"', builtin.registers, { desc = "Telescope registers" })

    vim.keymap.set("n", "<leader>fa", builtin.autocommands, { desc = "Telescope autocommands" })

    vim.keymap.set("n", "<leader>fc", builtin.command_history, { desc = "Telescope command history" })
    vim.keymap.set("n", "<leader>fC", builtin.commands, { desc = "Telescope commands" })

    vim.keymap.set(
      "n",
      "<leader>f/",
      builtin.current_buffer_fuzzy_find,
      { desc = "Telescope current buffer fuzzy find" }
    )

    vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Telescope quickfix" })
    vim.keymap.set("n", "<leader>ft", builtin.treesitter, { desc = "Telescope treesitter" })

    vim.keymap.set("n", "<leader>ld", builtin.lsp_definitions, { desc = "Telescope lsp definitions" })
    vim.keymap.set(
      "n",
      "<leader>lD",
      ":vsplit<CR> :lua vim.lsp.buf.definition()<CR>",
      { desc = "Telescope lsp definitions in vsplit" }
    )
    vim.keymap.set("n", "<leader>lr", builtin.lsp_references, { desc = "Telescope lsp references" })
    vim.keymap.set("n", "<leader>li", builtin.lsp_implementations, { desc = "Telescope lsp implementations" })
    vim.keymap.set("n", "<leader>lci", builtin.lsp_incoming_calls, { desc = "Telescope lsp incoming calls" })
    vim.keymap.set("n", "<leader>lco", builtin.lsp_outgoing_calls, { desc = "Telescope lsp outgoing calls" })
    vim.keymap.set("n", "<leader>lt", builtin.lsp_type_definitions, { desc = "Telescope lsp type definitions" })
    vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "Telescope document symbols" })

    vim.keymap.set("n", "<leader>fl", builtin.reloader, { desc = "Telescope reloader" })

    vim.keymap.set("n", "<leader>fL", function()
      builtin.find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") })
    end, { desc = "Telescope find files in config" })

    vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Telescope git commits" })
    vim.keymap.set("n", "<leader>gC", builtin.git_bcommits, { desc = "Telescope buffer git commits" })
    vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Telescope git status" })
    vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Telescope git branches" })

    vim.keymap.set("n", "<leader>fm", "<cmd>Telescope myles<CR>", { desc = "Telescope find files with myles" })

    -- local find_buildfile = function()
    --   local Job = require("plenary.job")
    --   local path = vim.api.nvim_buf_get_name(0)
    --   Job:new({
    --     command = "buck",
    --     args = { "query", "buildfile(owner(" .. path .. "))" },
    --     cwd = "/usr/local/bin",
    --     env = { PATH = vim.env.PATH },
    --     on_exit = function(j, return_val)
    --       print(return_val)
    --       print(j:result())
    --     end,
    --   }):sync()
    -- end

    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local jump_to_buck = function(opts)
      opts = opts or {}
      local path = vim.api.nvim_buf_get_name(0)
      pickers
          .new(opts, {
            prompt_title = "Jump to BUCK",
            finder = finders.new_oneshot_job({ "buck", "query", "buildfile(owner(" .. path .. "))" }, opts),
            sorter = conf.generic_sorter(opts),
            previewer = conf.cat_previewer,
          })
          :find()
    end
    vim.keymap.set("n", "<leader>mB", jump_to_buck, { desc = "Jump to BUCK" })
  end,
}
