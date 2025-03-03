local prefill_edit_window = function(request)
  require("avante.api").edit()
  local code_bufnr = vim.api.nvim_get_current_buf()
  local code_winid = vim.api.nvim_get_current_win()
  if code_bufnr == nil or code_winid == nil then
    return
  end
  vim.api.nvim_buf_set_lines(code_bufnr, 0, -1, false, { request })
  vim.api.nvim_win_set_cursor(code_winid, { 1, #request + 1 })
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-s>", true, true, true), "v", true)
end

-- Prompt templates
local avante_grammar_correction = "Correct the text to standard English, but keep any code blocks inside intact."
local avante_keywords = "Extract the main keywords from the following text"
local avante_code_readability_analysis = [[
You must identify any readability issues in the code snippet.
Some readability issues to consider:
- Unclear naming
- Unclear purpose
- Redundant or obvious comments
- Lack of comments
- Long or complex one liners
- Too much nesting
- Long variable names
- Inconsistent naming and code style.
- Code repetition
You may identify additional problems. The user submits a small section of code from a larger file.
Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
If there's no issues with code respond with only: <OK>
]]
local avante_optimize_code = "Optimize the following code"
local avante_summarize = "Summarize the following text"
local avante_translate = "Translate this into Chinese, but keep any code blocks inside intact"
local avante_explain_code = "Explain the following code"
local avante_complete_code = "Complete the following codes written in " .. vim.bo.filetype
local avante_add_docstring = "Add docstring to the following codes"
local avante_fix_bugs = "Fix the bugs inside the following codes if any"
local avante_add_tests = "Implement tests for the following code"

return {
  {
    "olimorris/codecompanion.nvim",
    enabled = false,
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
    ---@module 'avante'
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
    opts = {
      provider = "claude",
      behaviour = {
        auto_apply_diff_after_generation = true,
      },
      vendors = {
        groq = { -- define groq provider
          __inherited_from = "openai",
          api_key_name = "GROQ_API_KEY", -- pragma: allowlist secret
          endpoint = "https://api.groq.com/openai/v1/",
          model = "llama-3.3-70b-versatile",
          max_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
        },
      },
      file_selector = { provider = "snacks" },
    },
    build = "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" },
      },
    },
    keys = {
      -- Normal & Visual Mode (ask)
      {
        "<leader>ag",
        function()
          require("avante.api").ask({ question = avante_grammar_correction })
        end,
        mode = { "n", "v" },
        desc = "Grammar Correction (ask)",
      },
      {
        "<leader>ak",
        function()
          require("avante.api").ask({ question = avante_keywords })
        end,
        mode = { "n", "v" },
        desc = "Keywords (ask)",
      },
      {
        "<leader>al",
        function()
          require("avante.api").ask({ question = avante_code_readability_analysis })
        end,
        mode = { "n", "v" },
        desc = "Code Readability Analysis (ask)",
      },
      {
        "<leader>ao",
        function()
          require("avante.api").ask({ question = avante_optimize_code })
        end,
        mode = { "n", "v" },
        desc = "Optimize Code (ask)",
      },
      {
        "<leader>am",
        function()
          require("avante.api").ask({ question = avante_summarize })
        end,
        mode = { "n", "v" },
        desc = "Summarize text (ask)",
      },
      {
        "<leader>an",
        function()
          require("avante.api").ask({ question = avante_translate })
        end,
        mode = { "n", "v" },
        desc = "Translate text (ask)",
      },
      {
        "<leader>ax",
        function()
          require("avante.api").ask({ question = avante_explain_code })
        end,
        mode = { "n", "v" },
        desc = "Explain Code (ask)",
      },
      {
        "<leader>ac",
        function()
          require("avante.api").ask({ question = avante_complete_code })
        end,
        mode = { "n", "v" },
        desc = "Complete Code (ask)",
      },
      {
        "<leader>ad",
        function()
          require("avante.api").ask({ question = avante_add_docstring })
        end,
        mode = { "n", "v" },
        desc = "Docstring (ask)",
      },
      {
        "<leader>ab",
        function()
          require("avante.api").ask({ question = avante_fix_bugs })
        end,
        mode = { "n", "v" },
        desc = "Fix Bugs (ask)",
      },
      {
        "<leader>au",
        function()
          require("avante.api").ask({ question = avante_add_tests })
        end,
        mode = { "n", "v" },
        desc = "Add Tests (ask)",
      },

      -- Visual Mode (edit)
      {
        "<leader>aG",
        function()
          prefill_edit_window(avante_grammar_correction)
        end,
        mode = { "v" },
        desc = "Grammar Correction (edit)",
      },
      {
        "<leader>aK",
        function()
          prefill_edit_window(avante_keywords)
        end,
        mode = { "v" },
        desc = "Keywords (edit)",
      },
      {
        "<leader>aO",
        function()
          prefill_edit_window(avante_optimize_code)
        end,
        mode = { "v" },
        desc = "Optimize Code (edit)",
      },
      {
        "<leader>aC",
        function()
          prefill_edit_window(avante_complete_code)
        end,
        mode = { "v" },
        desc = "Complete Code (edit)",
      },
      {
        "<leader>aD",
        function()
          prefill_edit_window(avante_add_docstring)
        end,
        mode = { "v" },
        desc = "Docstring (edit)",
      },
      {
        "<leader>aB",
        function()
          prefill_edit_window(avante_fix_bugs)
        end,
        mode = { "v" },
        desc = "Fix Bugs (edit)",
      },
      {
        "<leader>aU",
        function()
          prefill_edit_window(avante_add_tests)
        end,
        mode = { "v" },
        desc = "Add Tests (edit)",
      },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    optional = true,
    opts = {
      panel = { enabled = false },
      suggestion = { enabled = false },
      filetypes = { ["*"] = true },
    },
  },
  ---@module 'blink.cmp'
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "Kaiser-Yang/blink-cmp-avante",
      "giuxtaposition/blink-cmp-copilot", -- Blink Copilot Source
    },
    opts_extend = { "sources.default" },

    ---@type blink.cmp.Config
    opts = {
      completion = {
        accept = { auto_brackets = { enabled = true } },
        menu = { border = "single", draw = { treesitter = { "lsp" } } },
        documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = "single" } },
      },
      signature = { enabled = true, window = { border = "single" } },
      sources = {
        default = { "avante", "copilot", "lsp", "path", "snippets", "buffer" },
        per_filetype = {
          AvanteInput = { "avante" },
          lua = { "lsp", "path", "snippets", "buffer", "lazydev" },
          sql = { "snippets", "dadbod", "buffer" },
        },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            transform_items = function(_, items)
              local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
              local kind_idx = #CompletionItemKind + 1
              CompletionItemKind[kind_idx] = "Copilot"
              for _, item in ipairs(items) do
                item.kind = kind_idx
              end
              return items
            end,
            score_offset = 100,
          },
          avante = { module = "blink-cmp-avante", name = "Avante" },
          lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
        },
      },
      appearance = {
        kind_icons = {
          copilot = "",
          Copilot = "",
          Text = "󰉿",
          Method = "󰊕",
          Function = "󰊕",
          Constructor = "󰒓",

          Field = "󰜢",
          Variable = "󰆦",
          Property = "󰖷",

          Class = "󱡠",
          Interface = "󱡠",
          Struct = "󱡠",
          Module = "󰅩",

          Unit = "󰪚",
          Value = "󰦨",
          Enum = "󰦨",
          EnumMember = "󰦨",

          Keyword = "󰻾",
          Constant = "󰏿",

          Snippet = "󱄽",
          Color = "󰏘",
          File = "󰈔",
          Reference = "󰬲",
          Folder = "󰉋",
          Event = "󱐋",
          Operator = "󰪚",
          TypeParameter = "󰬛",
        },
      },
    },
  },
}
