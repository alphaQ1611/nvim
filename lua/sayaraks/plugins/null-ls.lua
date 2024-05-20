return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Formatter
        null_ls.builtins.formatting.gofumpt,
        -- Import revisions
        null_ls.builtins.formatting.goimports,
      },
      on_attach = function(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
          local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
    })
  end,
}
