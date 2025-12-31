return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
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
    "preservim/vimux",
    cmd = {
      "VimuxRunCommand",
      "VimuxSendText",
      "VimuxSendKeys",
      "VimuxOpenRunner",
      "VimuxRunLastCommand",
      "VimuxCloseRunner",
      "VimuxInspectRunner",
      "VimuxInterruptRunner",
      "VimuxPromptCommand",
      "VimuxClearTerminalScreen",
      "VimuxClearRunnerHistory",
      "VimuxZoomRunner",
    },
    keys = {
      {
        "<leader>tl",
        function()
          local current_directory = vim.fn.expand("%:p:h") -- Get the current file's directory
          vim.cmd(string.format("VimuxRunCommand('cd %s && kube-lint .')", current_directory))
        end,
        desc = "Run kustomize lint",
      },
      { "<leader>tz", "<cmd>VimuxZoomRunner<cr>", desc = "Zoom runner" },
    },
  },
  {
    "mbbill/undotree",

    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end,
  },
}
