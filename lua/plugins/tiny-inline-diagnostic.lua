return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy",
	priority = 1000,
	config = function()
		require("tiny-inline-diagnostic").setup({
			preset = "classic",
			transparent_bg = false,
			transparent_cursorLine = false,
		})
		vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
	end,
}
