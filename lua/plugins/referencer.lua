return {
	"romus204/referencer.nvim",
	config = function()
		require("referencer").setup()
	end,
	keys = { { "<leader>ur", "<cmd>ReferencerToggle<cr>", desc = "Toggle reference counts" } },
}
