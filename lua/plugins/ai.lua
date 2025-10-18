return {
  -- Opencode.nvim {{{
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recommended for `ask()` and `select()`.
      -- Required for `toggle()`.
      { "folke/snacks.nvim", opts = { input = {}, picker = {} } },
    },
    config = function()
      vim.g.opencode_opts = {
        -- Your configuration, if any — see `lua/opencode/config.lua`
      }

      -- Required for `vim.g.opencode_opts.auto_reload`
      vim.opt.autoread = true

      -- Recommended/example keymaps
      vim.keymap.set({ "n", "x" }, "<leader>oa", function()
        require("opencode").ask("@this: ", { submit = true })
      end, { desc = "Ask about this" })
      vim.keymap.set({ "n", "x" }, "<leader>os", function()
        require("opencode").select()
      end, { desc = "Select prompt" })
      vim.keymap.set({ "n", "x" }, "<leader>o+", function()
        require("opencode").prompt("@this")
      end, { desc = "Add this" })
      vim.keymap.set("n", "<leader>ot", function()
        require("opencode").toggle()
      end, { desc = "Toggle embedded" })
      vim.keymap.set("n", "<leader>oc", function()
        require("opencode").command()
      end, { desc = "Select command" })
      vim.keymap.set("n", "<leader>on", function()
        require("opencode").command("session_new")
      end, { desc = "New session" })
      vim.keymap.set("n", "<leader>oi", function()
        require("opencode").command("session_interrupt")
      end, { desc = "Interrupt session" })
      vim.keymap.set("n", "<leader>oA", function()
        require("opencode").command("agent_cycle")
      end, { desc = "Cycle selected agent" })
      vim.keymap.set("n", "<S-C-u>", function()
        require("opencode").command("messages_half_page_up")
      end, { desc = "Messages half page up" })
      vim.keymap.set("n", "<S-C-d>", function()
        require("opencode").command("messages_half_page_down")
      end, { desc = "Messages half page down" })
    end,
  },
  -- }}} End Opencode.nvim
  -- copilot {{{
  {
    "zbirenbaum/copilot.lua",
    optional = true,
    opts = {
      panel = { enabled = false },
      suggestion = { enabled = false },
      filetypes = { ["*"] = true },
    },
  },
  -- }}}
  -- mcphub {{{
  -- {
  --   "ravitemer/mcphub.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
  --   },
  --   -- cmd = "MCPHub", -- lazily start the hub when `MCPHub` is called
  --   build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
  --   config = function()
  --     require("mcphub").setup({
  --       -- Required options
  --       port = 3000, -- Port for MCP Hub server
  --       config = vim.fn.expand("~/mcpservers.json"), -- Absolute path to config file
  --
  --       -- Optional options
  --       on_ready = function(hub)
  --         -- Called when hub is ready
  --       end,
  --       on_error = function(err)
  --         -- Called on errors
  --       end,
  --       log = {
  --         level = vim.log.levels.WARN,
  --         to_file = false,
  --         file_path = nil,
  --         prefix = "MCPHub",
  --       },
  --     })
  --   end,
  -- },
  -- }}}
  --

  -- Blink.cmp {{{
  --- @module 'blink.cmp'
  -- {
  --   "saghen/blink.cmp",
  --   dependencies = {
  --     "rafamadriz/friendly-snippets",
  --     "Kaiser-Yang/blink-cmp-avante",
  --     "giuxtaposition/blink-cmp-copilot", -- Blink Copilot Source
  --   },
  --   opts_extend = { "sources.default" },
  --
  --   ---@type blink.cmp.Config
  --   opts = {
  --     completion = {
  --       accept = { auto_brackets = { enabled = true } },
  --       menu = { border = "single", draw = { treesitter = { "lsp" } } },
  --       documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = "single" } },
  --     },
  --     signature = { enabled = true, window = { border = "single" } },
  --     sources = {
  --       default = { "avante", "copilot", "lsp", "path", "snippets", "buffer" },
  --       per_filetype = {
  --         AvanteInput = { "avante" },
  --         lua = { "lsp", "path", "snippets", "buffer", "lazydev" },
  --         sql = { "snippets", "dadbod", "buffer" },
  --       },
  --       providers = {
  --         copilot = {
  --           name = "copilot",
  --           module = "blink-cmp-copilot",
  --           transform_items = function(_, items)
  --             local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
  --             local kind_idx = #CompletionItemKind + 1
  --             CompletionItemKind[kind_idx] = "Copilot"
  --             for _, item in ipairs(items) do
  --               item.kind = kind_idx
  --             end
  --             return items
  --           end,
  --           score_offset = 100,
  --         },
  --         avante = { module = "blink-cmp-avante", name = "Avante" },
  --         lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
  --       },
  --     },
  --     appearance = {
  --       kind_icons = {
  --         copilot = "",
  --         Copilot = "",
  --         Text = "󰉿",
  --         Method = "󰊕",
  --         Function = "󰊕",
  --         Constructor = "󰒓",
  --
  --         Field = "󰜢",
  --         Variable = "󰆦",
  --         Property = "󰖷",
  --
  --         Class = "󱡠",
  --         Interface = "󱡠",
  --         Struct = "󱡠",
  --         Module = "󰅩",
  --
  --         Unit = "󰪚",
  --         Value = "󰦨",
  --         Enum = "󰦨",
  --         EnumMember = "󰦨",
  --
  --         Keyword = "󰻾",
  --         Constant = "󰏿",
  --
  --         Snippet = "󱄽",
  --         Color = "󰏘",
  --         File = "󰈔",
  --         Reference = "󰬲",
  --         Folder = "󰉋",
  --         Event = "󱐋",
  --         Operator = "󰪚",
  --         TypeParameter = "󰬛",
  --       },
  --     },
  --   },
  -- },
  -- }}} End Blink.cmp
}
