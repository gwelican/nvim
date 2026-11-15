local python_path = os.getenv("ESPHOME_PYTHON")
  or "/Users/gwelican/.local/share/uv/tools/esphome/bin/python"

local function is_esphome(buf)
  for _, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, 200, false)) do
    if vim.startswith(line, "esphome:") then
      return true
    end
  end
  return false
end

local function flush_esphome_document(bufnr)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    if client.name == "esphome" then
      vim.lsp._changetracking.flush(client, bufnr)

      client:notify("textDocument/didChange", {
        textDocument = {
          uri = vim.uri_from_bufnr(bufnr),
          version = vim.lsp.util.buf_versions[bufnr],
        },
        contentChanges = {
          { text = vim.lsp._buf_get_full_text(bufnr) },
        },
      })
    end
  end
end

return {
  {
    "sublimelsp/LSP-esphome",
    lazy = false,
    priority = 1000,

    config = function()
      local entry = require("lazy.core.config").plugins["LSP-esphome"]
      local node = vim.fn.exepath("node")
      local server = entry and entry.dir .. "/language-server/out/server.js"

      if not entry or node == "" or vim.fn.filereadable(server) == 0 then
        vim.notify("ESPHome LSP server missing. Install Node.js and restart Neovim.", vim.log.levels.WARN)
        return
      end

      vim.treesitter.language.register("yaml", "esphome")

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        pattern = "*.yaml,*.yml",
        callback = function(ev)
          if is_esphome(ev.buf) then
            vim.bo[ev.buf].filetype = "esphome"
          end
        end,
      })

      vim.lsp.config("esphome", {
        cmd = { node, server, "--stdio" },
        filetypes = { "esphome" },
        single_file_support = true,
        initialization_options = { pythonPath = python_path },
        settings = {
          esphome = {
            validator = "local",
            pythonPath = python_path,
          },
        },
        root_dir = function(path)
          if type(path) ~= "string" then
            path = vim.api.nvim_buf_get_name(path)
          end
          if path == "" then
            return vim.fn.getcwd()
          end
          local marker = vim.fs.find({ "secrets.yaml", ".git" }, { path = path, upward = true })[1]
          return marker and vim.fs.dirname(marker) or vim.fs.dirname(path)
        end,
      })

      local config = vim.lsp.config["esphome"]

      local function start(buf)
        if vim.bo[buf].filetype ~= "esphome" then
          return
        end

        for _, client in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
          if client.name == "esphome" then
            return
          end
        end

        vim.lsp.start(config, { bufnr = buf })
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "esphome",
        callback = function(ev)
          start(ev.buf)
        end,
      })

      vim.lsp.enable("esphome")

      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        start(buf)
      end
    end,
  },

  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      sources = {
        providers = {
          lsp = {
            override = {
              get_completions = function(self, ctx, callback)
                local bufnr = ctx.bufnr or 0
                flush_esphome_document(bufnr)
                return require("blink.cmp.sources.lsp").new(self.opts):get_completions(ctx, callback)
              end,
            },
          },
        },
      },
    },
  },
}
