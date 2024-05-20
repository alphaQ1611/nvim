return {
  "f-person/git-blame.nvim",
  config = function()
    require("gitblame").setup({
      enabled = false,
    })
    vim.keymap.set("n", "<leader>gb", ":GitBlameToggle<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>gcp", ":GitBlameCopySHA<CR>", { noremap = true, silent = true })
  end,
}
