-- vim.g.tundra_biome = "arctic"
-- vim.opt.background = "dark"

require("catppuccin").setup({
    flavour = "mocha",
    styles = {
        comments = { "bold" },
    }
})

vim.cmd("colorscheme catppuccin")
