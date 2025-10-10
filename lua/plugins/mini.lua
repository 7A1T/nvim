return {
	{
		"echasnovski/mini.files",
		version = false,
		keys = {
			{
				"<leader>e",
				function()
					require("mini.files").open()
				end,
				desc = "File Explorer",
			},
		},
		opts = {},
	},
	{
		"echasnovski/mini.sessions",
		version = false,
		lazy = false,
		opts = {},
	},
	{
		"echasnovski/mini.surround",
		version = false,
		keys = {
			{ "sa", mode = { "n", "v" } },
			{ "sd", mode = { "n" } },
			{ "sr", mode = { "n" } },
			{ "sf", mode = { "n" } },
			{ "sF", mode = { "n" } },
			{ "sh", mode = { "n" } },
			{ "sn", mode = { "n" } },
		},
		opts = {},
	},
}
