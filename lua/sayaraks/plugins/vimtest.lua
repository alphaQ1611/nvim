return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-go",
  },

  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-go")({
          dap = { justMyCode = false },
        }),
      },
      vim.keymap.set("n", "<leader>tr", ':lua require("neotest").run.run()<CR>'),
      vim.keymap.set("n", "<leader>ta", ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>'),
      vim.keymap.set("n", "<leader>to", ':lua require("neotest").output.open({ enter = true, auto_close = true })<CR>'),
    })
  end,
}
