return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "gopls", "rust_analyzer" },
			})

			-- Diagnostic config (once)
			vim.diagnostic.config({
				-- ... your diagnostic settings
			})

			-- Enable all servers (native API)
			vim.lsp.enable({ "lua_ls", "gopls", "rust_analyzer" })
		end,
	},
}
