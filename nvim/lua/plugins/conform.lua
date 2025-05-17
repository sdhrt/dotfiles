local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		go = { "crlfmt" },
		css = { "cssls" },
		json = { "prettier" },
		lua = { "stylua" },
		python = function(bufnr)
			if require("conform").get_formatter_info("ruff_format", bufnr).available then
				return { "ruff_format" }
			else
				return { "isort", "black" }
			end
		end,
	},
})

vim.keymap.set({ "n", "v" }, "<leader>fm", function()
	conform.format({
		lsp_fallback = true,
		async = true,
		timeout_ms = 500,
	})
end, { desc = "Format file or range (in visual mode)" })
