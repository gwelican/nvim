return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim", -- required by telescope
    -- "MunifTanjim/nui.nvim",

    -- optional
    "nvim-treesitter/nvim-treesitter",
    -- "rcarriga/nvim-notify",
    "nvim-tree/nvim-web-devicons",
  },
  -- config = function()
  --   require('leetcode').setup {
  --     workspace = '~/leetcode',
  --     leetcode = {
  --     };
  --   require('notify').setup {
  --     background_colour = '#000000',
  --   }
  -- end,
  opts = {
    lang = "python3"
    -- configuration goes here
  },
}
