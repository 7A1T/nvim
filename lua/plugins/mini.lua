return {
	"nvim-mini/mini.nvim",
	version = false,
	config = function()
		require("mini.files").setup()
		require("mini.sessions").setup()
		-- require("mini.ai").setup()
		require("mini.surround").setup()
		-- require("mini.operators").setup()
	end,
	keys = { {
		"<leader>e",
		"<cmd>:lua MiniFiles.open()<cr>",
		desc = "Git Blame Line",
	} },
}
