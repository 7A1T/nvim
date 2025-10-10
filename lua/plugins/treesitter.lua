return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		opts = {
			ensure_installed = {
				"lua",
				"python",
				"javascript",
				"typescript",
				"vimdoc",
				"vim",
				"regex",
				"terraform",
				"sql",
				"dockerfile",
				"toml",
				"json",
				"java",
				"groovy",
				"go",
				"gomod",
				"gowork",
				"gosum",
				"gitignore",
				"graphql",
				"yaml",
				"make",
				"cmake",
				"markdown",
				"markdown_inline",
				"bash",
				"tsx",
				"css",
				"html",
				"c",
				"cpp",
				"rust",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
				disable = { "ruby" },
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)

			-- Setup folding
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.opt.foldenable = true
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPost", "BufNewFile" },
		opts = function()
			local tsc = require("treesitter-context")
			Snacks.toggle({
				name = "Treesitter Context",
				get = tsc.enabled,
				set = function(state)
					if state then
						tsc.enable()
					else
						tsc.disable()
					end
				end,
			}):map("<leader>ut")
			return { mode = "cursor", max_lines = 3 }
		end,
	},
}
