return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- Customize golangcilint to ignore exit codes
		lint.linters.golangcilint.ignore_exitcode = true

		-- Configure linters by filetype
		lint.linters_by_ft = {
			go = { "golangcilint" },
			lua = { "luacheck" },
			sh = { "shellcheck" },
			bash = { "shellcheck" },
			zsh = { "shellcheck" },
			python = { "ruff" },
		}

		-- Auto-lint on save and text changes
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				local linters = lint.linters_by_ft[vim.bo.filetype]
				if linters and #linters > 0 then
					lint.try_lint()
				end
			end,
		})
	end,
	keys = {
		{
			"<leader>ll",
			function()
				require("lint").try_lint()
			end,
			desc = "Trigger linting",
		},
		{
			"<leader>li",
			function()
				local lint = require("lint")
				local linters = lint.linters_by_ft[vim.bo.filetype] or {}
				if #linters == 0 then
					vim.notify("No linters configured for: " .. vim.bo.filetype, vim.log.levels.INFO)
				else
					vim.notify("Linters: " .. table.concat(linters, ", "), vim.log.levels.INFO)
				end
			end,
			desc = "Show linters",
		},
	},
}
