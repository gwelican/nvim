return {
  {
    "Wansmer/treesj",
    keys = {
      { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = {
      use_default_keymaps = false,
      max_join_length = 150,
    },
  },
  -- {
  --   "stevearc/conform.nvim",
  --   optional = true,
  --   opts = {
  --     formatters_by_ft = {
  --       ["yaml"] = { "yamlfmt " },
  --     },
  --     -- formatters = {
  --     --   dprint = {
  --     --     condition = function(_, ctx)
  --     --       return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
  --     --     end,
  --     --   },
  --     -- },
  --   },
  -- },
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
}
