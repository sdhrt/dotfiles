local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "catgoose/nvim-colorizer.lua",
        event = "BufReadPre",
        opts = {
        },
    },
    {
        "sam4llis/nvim-tundra",
        lazy = false,
        priority = 1000,
    },
    {
        "drewxs/ash.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "webhooked/kanso.nvim",
        lazy = true,
        priority = 1000,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    { "williamboman/mason-lspconfig.nvim" },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
    },

    { -- Fuzzy Finder (files, lsp, etc)
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins.telescope")
        end,
    },

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
            return vim.fn.executable("make") == 1
        end,
    },

    { -- Autocompletion
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            {
                "L3MON4D3/LuaSnip",
                dependencies = { "rafamadriz/friendly-snippets" },
                after = "nvim-cmp",
                config = function()
                    require("plugins.luasnip")
                end,
            },
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            require("plugins.cmp")
        end,
    },

    { -- Set lualine as statusline
        "nvim-lualine/lualine.nvim",
        config = function()
            require("plugins.lualine")
        end,
    },

    {
        "kdheepak/tabline.nvim",
        config = function()
            require("plugins.tabline")
        end,
    },

    { -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            require("plugins.treesitter")
        end,
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("plugins.neotree")
        end,
    },

    { -- install without yarn or npm
        "iamcco/markdown-preview.nvim",
        priority = 10,
        config = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    { -- Collection of various small independent plugins/modules
        "echasnovski/mini.nvim",
        config = function()
            -- Better Around/Inside textobjects
            --
            -- Examples:
            --  - va)  - [V]isually select [A]round [)]paren
            --  - yinq - [Y]ank [I]nside [N]ext [']quote
            --  - ci'  - [C]hange [I]nside [']quote
            require("mini.ai").setup({ n_lines = 500 })

            require("mini.comment").setup()

            -- Add/delete/replace surroundings (brackets, quotes, etc.)
            --
            -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
            -- - sd'   - [S]urround [D]elete [']quotes
            -- - sr)'  - [S]urround [R]eplace [)] [']
            require("mini.surround").setup()

            -- Automatically add pairs
            require("mini.pairs").setup()

            -- split and join arguments
            require("mini.splitjoin").setup()

            -- indent
            --
        end,
    },
    {
        "shellRaining/hlchunk.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("hlchunk").setup({
                chunk = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
            })
        end,
    },
    { -- formatter plugin
        "stevearc/conform.nvim",
        opts = {},
        config = function()
            require("plugins.conform")
        end,
    },
})

require("plugins.lsp")
