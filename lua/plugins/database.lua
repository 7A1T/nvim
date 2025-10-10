return {
	"tpope/vim-dadbod",
	dependencies = {
		"kristijanhusak/vim-dadbod-ui",
		"kristijanhusak/vim-dadbod-completion",
	},
	cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
	keys = {
		{ "<leader>dbu", "<cmd>DBUIToggle<cr>", desc = "Database: Toggle UI" },
		{ "<leader>dbf", "<cmd>DBUIFindBuffer<cr>", desc = "Database: Find Buffer" },
		{ "<leader>dbr", "<cmd>DBUIRenameBuffer<cr>", desc = "Database: Rename Buffer" },
		{ "<leader>dbl", "<cmd>DBUILastQueryInfo<cr>", desc = "Database: Last Query Info" },
	},
	init = function()
		-- Setup database completion for SQL files
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "sql", "mysql", "plsql" },
			callback = function()
				local cmp = require("cmp")
				if cmp then
					cmp.setup.buffer({
						sources = {
							{ name = "vim-dadbod-completion" },
							{ name = "buffer" },
						},
					})
				end
			end,
			desc = "Setup database completion for SQL files",
		})

		-- Database UI settings
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_show_database_icon = 1
		vim.g.db_ui_force_echo_notifications = 1
		vim.g.db_ui_win_position = "left"
		vim.g.db_ui_winwidth = 30
	end,
}

