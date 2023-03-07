local map = require("globals.utils").map

map("i", "kk", "<Esc>")

map("n", "<C-n>", ":NvimTreeToggle<CR>")

map("n", "<leader>fm", ":lua vim.lsp.buf.format()<CR>")

map("i", "<C-l>", "<Right>")
map("i", "<C-h>", "<Left>")
map("i", "<C-j>", "<Up>")
map("i", "<C-k>", "<Down>")

map('n', "<Tab>", ":bn<CR>")
map('n', "<leader>x", ":bd<CR>")
