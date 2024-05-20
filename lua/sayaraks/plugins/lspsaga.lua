return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  config = function()
    require("lspsaga").setup({})
    vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", { silent = true, noremap = true })
    vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", { silent = true, noremap = true })
    vim.keymap.set("x", "<leader>cA", ":<c-u>Lspsaga range_code_action<cr>", { silent = true, noremap = true })
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", { silent = true, noremap = true })
    vim.keymap.set("n", "<leader>ggd", "<cmd>Lspsaga show_line_diagnostics<cr>", { silent = true, noremap = true })
    vim.keymap.set("n", "<leader>dg", "<cmd>Lspsaga diagnostic_jump_next<cr>", { silent = true, noremap = true })
    vim.keymap.set("n", "<leader>dp", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { silent = true, noremap = true })
    vim.keymap.set("n", "<leader>tt", "<cmd>Lspsaga term_toggle<cr>", { silent = true, noremap = true })
    vim.keymap.set("t", "<leader>tt", [[<C-\><C-n>:<C-u>Lspsaga term_toggle<CR>]], { silent = true, noremap = true })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
  },
  --- In lsp attach function
}
