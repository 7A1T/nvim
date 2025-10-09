-- Standalone plugins with less than 10 lines of config go here
return {
	{
		-- Hints keybinds
		"folke/which-key.nvim",
		opts = {
			preset = "helix",
		},
	},
	{
		-- Powerful Git integration for Vim
		"tpope/vim-fugitive",
	},
	{
		-- GitHub integration for vim-fugitive
		"tpope/vim-rhubarb",
	},
	{
		-- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		-- High-performance color highlighter
		"norcalli/nvim-colorizer.lua",
		opts = {},
	},
	{
		-- Detect tabstop and shiftwidth automatically
		"tpope/vim-sleuth",
	},
	{
		"andythigpen/nvim-coverage",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("coverage").setup({
				lang = {
					go = {
						coverage_file = vim.fn.getcwd() .. "/coverage.out",
					},
				},
			})
		end,
	},
	{
		-- Find and replace across project
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', desc = "Toggle Spectre" },
		},
		opts = {},
	},
}
