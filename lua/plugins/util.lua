return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "prettier",
        "mypy",
      },
    },
  },
  {
    "taybart/b64.nvim",
    cmd = { "B64Encode", "B64Decode" },
  },
  {
    "fei6409/log-highlight.nvim",
    event = "BufRead *.log",
    opts = {},
  },
  {
    "theprimeagen/vim-be-good",
    cmd = "VimBeGood",
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
