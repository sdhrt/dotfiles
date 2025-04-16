local map = require("globals.utils").map

vim.api.nvim_create_user_command("DelSwap", "!rm -rf ~/.local/state/nvim/swap/* <CR>", { desc = "Delete swap files" })

map("i", "kk", "<Esc>")

map("n", "<C-n>", ":Neotree toggle<CR>")

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "open diagnostic" })

vim.cmd("autocmd filetype py nnoremap <C-W> :w <bar> !python3 %<CR>")
vim.cmd("autocmd filetype c nnoremap <F5> :w <bar> !gcc -Wall % -o %:r.out <CR>")
vim.cmd("autocmd filetype cpp nnoremap <F5> :w <bar> !clang++ -std=c++17 -O2 -Wall % -o %:r.out <CR>")

map("i", "<C-l>", "<Right>")
map("i", "<C-h>", "<Left>")
map("i", "<C-j>", "<Up>")
map("i", "<C-k>", "<Down>")

map("n", "<Tab>", ":bn<CR>")
map("n", "<leader>x", ":bd<CR>")

map("n", "<leader>mm", ":MarkdownPreview<CR>")
map("n", "<leader>ms", ":MarkdownPreviewStop<CR>")
