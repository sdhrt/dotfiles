require("nvim-treesitter.configs").setup({
	ensure_installed = {'c','cpp','lua'},
	auto_install = false,
	highlight = {
		enable = true,
	},
})
