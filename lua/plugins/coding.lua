return {
  {
    "Wansmer/treesj",
    keys = {
      { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = {
      use_default_keymaps = false,
      max_join_length = 1550,
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        yaml = { "yamlfix" },
        json = { "fixjson" },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local neotest = require("neotest")
      neotest.setup({
        adapters = { require("neotest-python")({}) },
        env = {
          PATREON_PY_CONFIG_PATH = "/etc/patreon/testing.yml:patreon/config_test_circle.yml",
          SQLALCHEMY_SILENCE_UBER_WARNING = "1",
          RDEV = "1",
        },
      })
    end,
    keys = {
      {
        "<leader>tl",
        false,
      },
    },
  },
  {
    "yochem/jq-playground.nvim",
    cmd = { "JqPlayground" },
    keys = {
      { "<leader>jq", vim.cmd.JqPlayground },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "json5",
        "rust",
        "java",
        "cmake",
        "css",
        "gitcommit",
        "gitignore",
        "go",
        "http",
        -- "nix",
        "sql",
      })
    end,
  },
  {
    "klen/nvim-test",
    keys = {
      { "<leader>tT", "<cmd>TestFile<cr><cr>", desc = "Run test file" },
      { "<leader>tR", "<cmd>TestNearest<cr><cr>", desc = "Run TestNearest" },
    },
    config = function()
      require("nvim-test").setup({})
      require("nvim-test.runners.pytest"):setup({ command = "/home/dev/patreon_py/bin/rdev/pytest" })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = "LazyFile",
    opts = {
      linters_by_ft = {
        yaml = { "kubelint", "yamllint" },
        py = { "mypy" },
      },
      linters = {
        kubelint = {
          cmd = "kube-lint",
          condition = function(ctx)
            return vim.fs.find({ "kustomization.yaml" }, { path = ctx.filename, upward = true })[1]
          end,
          parser = function(output, bufnr)
            if vim.trim(output) == "" then
              return {}
            end
            local decoded = vim.json.decode(output)
            local diagnostics = {}
            local items = decoded["Reports"]
            if items == vim.v.null then
              return diagnostics
            end
            for _, item in pairs(items or {}) do
              table.insert(diagnostics, {
                lnum = 0,
                end_lnum = 0,
                col = 0,
                end_col = 0,
                message = item["Diagnostic"]["Message"],
                source = "kube-lint",
                severity = vim.diagnostic.severity.WARN,
              })
            end
            return diagnostics
          end,
        },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    config = function()
      require("neo-tree").setup({
        filesystem = {
          follow_current_file = {
            enabled = true,
          },

          commands = {
            avante_add_files = function(state)
              local node = state.tree:get_node()
              local filepath = node:get_id()
              local relative_path = require("avante.utils").relative_path(filepath)

              local sidebar = require("avante").get()

              local open = sidebar:is_open()
              -- ensure avante sidebar is open
              if not open then
                require("avante.api").ask()
                sidebar = require("avante").get()
              end

              sidebar.file_selector:add_selected_file(relative_path)

              -- remove neo tree buffer
              if not open then
                sidebar.file_selector:remove_selected_file("neo-tree filesystem [1]")
              end
            end,
          },
          window = {
            mappings = {
              ["oa"] = "avante_add_files",
            },
          },
        },
      })
    end,
  },
}
