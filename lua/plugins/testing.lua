return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			{ "fredrikaverpil/neotest-golang", version = "*" },
		},
		keys = {
			{ "<leader>trn", function() require("neotest").run.run() end, desc = "Test: Run Nearest" },
			{ "<leader>trf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test: Run File" },
			{ "<leader>trs", function() require("neotest").summary.toggle() end, desc = "Test: Toggle Summary" },
			{ "<leader>tro", function() require("neotest").output.open() end, desc = "Test: Open Output" },
			{ "<leader>trp", function() require("neotest").output_panel.toggle() end, desc = "Test: Toggle Output Panel" },
			{ "<leader>trw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Test: Toggle Watch" },
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-golang")({
						args = { "-v" },
						experimental = {
							test_table = true,
						},
					}),
				},
				output_panel = {
					enabled = true,
					open = "botright split | resize 15",
				},
				quickfix = {
					open = false,
				},
				status = {
					virtual_text = true,
					signs = true,
				},
			})
		end,
	},
}
