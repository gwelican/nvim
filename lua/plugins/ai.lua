return {
  {
    "olimorris/codecompanion.nvim",
    enabled = true,
    -- cmd = { "CodeCompanion" },
    opts = {
      display = {
        diff = {
          enabled = true,
          provider = "mini_diff",
        },
      },
      strategies = {
        chat = {
          adapter = "openai",
        },
        inline = {
          adapter = "openai",
        },
      },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    optional = true,
    opts = {
      filetypes = { ["*"] = true },
    },
  },
}
