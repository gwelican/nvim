local function is_esphome(bufnr)
  for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, 200, false)) do
    if vim.startswith(line, "esphome:") then
      return true
    end
  end
  return false
end

return {
  -- ships the compiled ESPHome language server; Neovim drives it through node
  {
    "sublimelsp/LSP-esphome",
    config = function()
      local server = LazyVim.get_plugin_path("LSP-esphome", "language-server/out/server.js")
      local node = vim.fn.exepath("node")
      if not server or vim.fn.filereadable(server) == 0 or node == "" then
        LazyVim.warn("ESPHome LSP unavailable: install Node.js", { title = "esphome", once = true })
        return
      end

      vim.treesitter.language.register("yaml", "esphome")

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        pattern = { "*.yaml", "*.yml" },
        callback = function(ev)
          if is_esphome(ev.buf) then
            vim.bo[ev.buf].filetype = "esphome"
          end
        end,
      })

      vim.lsp.config("esphome", {
        cmd = { node, server, "--stdio" },
        filetypes = { "esphome" },
        init_options = { pythonPath = vim.env.ESPHOME_PYTHON },
        settings = { esphome = { validator = "local" } },
        root_dir = function(bufnr, on_dir)
          on_dir(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":h"))
        end,
      })
      vim.lsp.enable("esphome")
    end,
  },
}
