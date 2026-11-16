return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "prettier",
        "mypy",
      },
    },
  },
  {
    "taybart/b64.nvim",
  },
  -- {
  --   "mistricky/codesnap.nvim",
  --   build = "make",
  -- },
  {
    "fei6409/log-highlight.nvim",
    event = "BufRead *.log",
    opts = {},
  },
  {
    "theprimeagen/vim-be-good",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>su", false },
    },
  },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>su", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
    },
  },
}
