vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
keymap.set("n", "<leader>q", function()
  require("telescope.builtin").quickfix()
  vim.cmd(":cclose")
end, { desc = "Open Quickfix (Telescope)" })

vim.api.nvim_set_keymap("n", "<leader>ee", ":Neotree toggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>er", ":Neotree refresh<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ef", ":Neotree reveal<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>eq", ":Neotree close<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>tx", "<cmd>bdelete<CR>", { desc = "Close current tab" }) -- close current tab

vim.api.nvim_set_keymap("n", "<leader>gd", ":DiffviewOpen ", { noremap = true, silent = false })

vim.api.nvim_set_keymap("n", "<leader>gD", ":DiffviewClose<CR>", { noremap = true, silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "<leader>p", [["_dP]])
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Remap 'd' to use the black hole register
map("n", "d", '"_d')
map("v", "d", '"_d')
map("n", "<leader>d", "d")
map("v", "<leader>d", "d")

-- Remap 'c' to use the black hole register
map("n", "c", '"_c')
map("v", "c", '"_c')
map("n", "<leader>c", "c")
map("v", "<leader>c", "c")

map("n", "<Tab>", ":bnext<CR>")
map("n", "<S-Tab>", ":bprev<CR>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
