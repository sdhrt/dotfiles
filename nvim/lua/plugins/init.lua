vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
        "sam4llis/nvim-tundra",
        config = function()
            require("globals.colorscheme")
        end
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'williamboman/mason.nvim',
                config = function()
                    require("mason").setup()
                end
            },
            { 'williamboman/mason-lspconfig.nvim', },
            {
                'j-hui/fidget.nvim',
                config = function()
                    require("fidget").setup()
                end
            },
            {
                'folke/neodev.nvim',
            }
        },
    },

    {
        "windwp/nvim-autopairs",
        config = require("nvim-autopairs").setup(),
    },

    -- Fuzzy Finder (files, lsp, etc)
    {
        'nvim-telescope/telescope.nvim',
        version = '*',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require("plugins.telescope")
        end
    },

    {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    },
    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            {
                'L3MON4D3/LuaSnip',
                dependencies = { "rafamadriz/friendly-snippets" },
                after = "nvim-cmp",
                config = function()
                    require("luasnip.loaders.from_vscode").load()
                    require("plugins.luasnip")
                end
            }
            , 'saadparwaiz1/cmp_luasnip' },
        config = function()
            require("plugins.cmp")
        end
    },
    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            winbar = {
                lualine_a = { 'buffers' },
                lualine_b = {},
            },
            options = {
                icons_enabled = false,
                theme = 'ayu_dark',
                component_separators = '|',
                section_separators = '',
            },
        },
    },
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        config = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
            require("plugins.treesitter")
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("plugins.nvimtree")
        end
    },
})

require("plugins.lsp")
