local map = require("globals.utils").map

map("i", "kk", "<Esc>")

map("n", "<C-n>", ":NeoTreeFocusToggle<CR>")

map("n", "<leader>fm", ":lua vim.lsp.buf.format()<CR>")
map("n", "<leader>d", ":lua vim.diagnostic.open_float(0,{scope='line',border='single'})<CR>")

vim.cmd("autocmd filetype c nnoremap <F5> :w <bar> !g++ -Wall % -o %:r.out <CR>")
vim.cmd("autocmd filetype cpp nnoremap <F5> :w <bar> !g++ -std=c++17 -O2 -Wall % -o %:r.out <CR>")

map("i", "<C-l>", "<Right>")
map("i", "<C-h>", "<Left>")
map("i", "<C-j>", "<Up>")
map("i", "<C-k>", "<Down>")

map('n', "<Tab>", ":bn<CR>")
map('n', "<leader>x", ":bd<CR>")

if (vim.bo.filetype == "c")
then
    print("wow")
    map('n', '<F5>', ":!g++ -g % -o %:r <CR>")
end
