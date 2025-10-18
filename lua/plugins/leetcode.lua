return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",

    -- optional
    "nvim-treesitter/nvim-treesitter",
    -- "rcarriga/nvim-notify",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>Lr", "<cmd>Leet run<cr>", desc = "Leetcode run" },
    { "<leader>Ls", "<cmd>Leet submit<cr>", desc = "leetcode submit" },
  },
  cmd = "Leet",
  lazy = false,
  opts = {
    lang = "python3",
    injector = {
      ["python3"] = {
        before = true,
      },
    },
    -- configuration goes here
  },
}
