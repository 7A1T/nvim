return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"jayp0521/mason-null-ls.nvim", -- ensure dependencies are installed
	},
	config = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting -- to setup formatters
		local diagnostics = null_ls.builtins.diagnostics -- to setup linters

		-- Formatters & linters for mason to install
		require("mason-null-ls").setup({
			ensure_installed = {
				"prettier", -- ts/js formatter
				"stylua", -- lua formatter
				"eslint_d", -- ts/js linter
				"shfmt", -- Shell formatter
				"checkmake", -- linter for Makefiles
				"ruff", -- Python linter and formatter
				"clang_format", -- c++ formatter
				"gofumpt", -- Go formatter
				"goimports", -- Go imports organizer
			},
			automatic_installation = true,
		})

		local sources = {
			diagnostics.checkmake,
			formatting.prettier.with({ filetypes = { "html", "json", "yaml", "markdown" } }),
			formatting.stylua,
			formatting.shfmt.with({ args = { "-i", "4" } }),
			formatting.terraform_fmt,
			formatting.clang_format,
			formatting.gofumpt,
			formatting.goimports,
			require("none-ls.formatting.ruff").with({ extra_args = { "--extend-select", "I" } }),
			require("none-ls.formatting.ruff_format"),
		}

		null_ls.setup({
			-- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
			sources = sources,
			-- LSP formatting on_attach is handled in core/autocmds.lua
		})
	end,
}
