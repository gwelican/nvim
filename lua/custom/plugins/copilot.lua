return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "InsertEnter",
  opts = {
    suggestion = {
      enabled = false,
      panel = {
        enabled = false,
      }
      -- keymap = {
        -- accept = "<tab>",
      -- }
    },
    filetypes = {
      markdown = true,
      help = true,
      python = true,
      lua = true,
      yaml = true,
    },

  },
}

