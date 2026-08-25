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
}
