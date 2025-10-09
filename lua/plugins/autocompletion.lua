return { -- Autocompletion

	"saghen/blink.cmp",
	dependencies = {
		{ "saghen/blink.compat" },
		{ "rafamadriz/friendly-snippets" },
		{ "samiulsami/cmp-go-deep", dependencies = { "kkharji/sqlite.lua" } },
		{
			"edte/blink-go-import.nvim",
			ft = "go",
			opts = {},
		},
	},

	version = "1.*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = { preset = "default" },
		appearance = {
			nerd_font_variant = "mono",
		},
		sources = {
			default = {
				"lsp",
				"path",
				"snippets",
				"buffer",
				"go_deep",
				"go_pkgs",
			},
			providers = {
				go_deep = {
					name = "go_deep",
					module = "blink.compat.source",
					min_keyword_length = 3,
					max_items = 5,
					---@module "cmp_go_deep"
					---@type cmp_go_deep.Options
					opts = {
						-- See below for configuration options
					},
				},
				go_pkgs = {
					module = "blink-go-import",
					name = "Import",
				},
			},
		},
		-- (Default) Only show the documentation popup when manually triggered
		completion = { documentation = { auto_show = true } },

		signature = { enabled = true },
		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
