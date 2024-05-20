return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")

    local mason_lspconfig = require("mason-lspconfig")

    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

        local telescope_builtin = require("telescope.builtin")

        -- Define the combined function
        function Open_quickfix_and_references()
          -- Open Telescope Quickfix
          local params = vim.lsp.util.make_position_params()
          local results = vim.lsp.buf_request_sync(0, "textDocument/references", params, 5000)

          if not results or vim.tbl_isempty(results) then
            print("No references found")
            return
          end

          -- Collect all references into a single list
          local locations = {}
          for _, res in pairs(results) do
            if res.result then
              vim.list_extend(locations, res.result)
            end
          end

          if vim.tbl_isempty(locations) then
            print("No references found")
            return
          end

          -- Convert LSP locations to quickfix items
          local quickfix_items = vim.lsp.util.locations_to_items(locations)

          -- Set the quickfix list
          vim.fn.setqflist(quickfix_items)

          -- Open the quickfix list with Telescope
          telescope_builtin.quickfix()
          vim.cmd(":cclose")
          -- Show LSP references
        end
        map("gr", ":lua Open_quickfix_and_references()<CR>", "[G]oto [R]eferences")

        map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

        map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        map("K", vim.lsp.buf.hover, "Hover Documentation")

        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
            end,
          })
        end

        -- The following autocommand is used to enable inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
      end,
    })

    local util = require("lspconfig/util")
    lspconfig.gopls.setup({
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "gowork" },
      root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    mason_lspconfig.setup_handlers({
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              -- make the language server recognize "vim" global
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
    })
  end,
}
