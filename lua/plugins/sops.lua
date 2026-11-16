return {
  {
    "lucidph3nx/nvim-sops",
    keys = {
      { "<leader>ze", vim.cmd.SopsEncrypt, desc = "Encrypt File (SOPS)" },
      { "<leader>zd", vim.cmd.SopsDecrypt, desc = "Decrypt File (SOPS)" },
    },
    opts = {},
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>z", group = "secrets" },
      },
    },
  },
}
