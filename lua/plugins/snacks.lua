return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		animate = { enabled = true }, -- animation library
		bigfile = { enabled = true }, -- prevents loading lsps for very large fiels
		bufdelete = { enabled = true }, -- better buffer deletion
		dashboard = { enabled = true }, -- homescreen
		debug = { enabled = false }, -- lua config debug info
		dim = { enabled = true }, -- dim surrounding code
		explorer = { enabled = true }, -- file explorer (picker)
		git = { enabled = true }, -- git show git blame_line
		gitbrowse = { enabled = true }, -- open file in git[hub|lab]
		image = { enabled = false }, -- image viewer
		indent = { enabled = true }, -- shows indentation lines
		input = { enabled = true }, -- hover input window for things like rename etc.
		layout = { enabled = true }, -- used by other snacks things for window management
		lazygit = { enabled = true }, -- opens lazygit in a hover window (git client)
		notifier = { -- notification popups (notify is used to send notifications)
			enabled = true,
			timeout = 3000,
		},
		picker = { enabled = true }, -- telescope replacement
		profiler = { enabled = false }, -- lua performance profiler
		quickfile = { enabled = true }, -- render file before loading plugins
		rename = { enabled = true }, -- lsp integration for file renaming
		scope = { enabled = true }, -- highlights code scope (class, func, etc)
		scratch = { enabled = true }, -- a temp scratchpad for making notes etc.
		scroll = { enabled = true }, -- smooth mouse scrolling
		statuscolumn = { enabled = true }, -- line num, git signs, breakpoints fold indication etc.
		terminal = { enabled = true }, -- terminals in neovim
		toggle = { enabled = true }, -- used to define toggles in whichkey
		win = { enabled = true }, -- used for managing floating windows and splits
		words = { enabled = true }, -- show lsp references and quickly navigate between them
		zen = { enabled = true }, -- opens floating window with no distrations
		styles = {
			notification = {
				-- wo = { wrap = true } -- Wrap notifications
			},
		},
	},
	-- Keymaps are now centralized in core/keymaps.lua
	-- Autocmds and toggle mappings are now in core/autocmds.lua
}
