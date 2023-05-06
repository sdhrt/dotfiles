require("neo-tree").setup({
    hide_root_node = true,
    close_if_last_window = true,
    default_component_configs = {
        indent = {
            indent_size = 2,
            padding = 1,
        },
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "ﰊ",
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon"
        },
        git_status = {
            symbols = {
                -- Change type
                added     = "",  -- or "✚", but this is redundant info if you use git_status_colors on the name
                modified  = "",  -- or "", but this is redundant info if you use git_status_colors on the name
                deleted   = "✖", -- this can only be used in the git_status source
                renamed   = "", -- this can only be used in the git_status source
                -- Status type
                untracked = "",
                ignored   = "",
                unstaged  = "",
                staged    = "",
                conflict  = "",
            }
        },
    },
    window = {
        width = 35
    },
})
