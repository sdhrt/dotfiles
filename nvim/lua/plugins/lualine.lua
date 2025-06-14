require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = "|",
        section_separators = "",
    },
    sections = {
        lualine_x = {
            {
                "diagnostics",
                symbols = { error = " ", warn = " ", info = " ", hint = " " },
                update_in_insert = true,
            },

        },
        lualine_y = {
            {
                'lsp_status',
                icon = '',
                symbols = {
                    spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
                    done = '✓',
                },
                ignore_lsp = { "emmet_ls", "tailwindcss" },
            }
        },
        lualine_z = { "location" }
    },
    extensions = { "neo-tree", "mason", "fzf", "lazy" }
})
