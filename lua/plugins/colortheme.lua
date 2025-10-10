return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "night",
			transparent = false,
			terminal_colors = true,
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				functions = {},
				variables = {},
			},
			on_highlights = function(hl, c)
				-- Custom highlight overrides
				hl.LineNr = { fg = c.fg_gutter }
			end,
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight")
		end,
	},

	-- Alternative colorschemes (lazy loaded)
	{
		"Mofiqul/vscode.nvim",
		lazy = true,
		opts = {
			style = "dark",
			transparent = false,
			italic_comments = true,
			underline_links = true,
			terminal_colors = true,
			color_overrides = {
				vscLineNumber = "#FFFFFF",
			},
		},
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
		opts = {
			terminal_colors = true,
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			inverse = true,
			contrast = "",
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = false,
		},
	},
}
