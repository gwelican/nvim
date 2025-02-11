return {
  {
    "olimorris/codecompanion.nvim",
    enabled = true,
    -- cmd = { "CodeCompanion" },
    opts = {
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
