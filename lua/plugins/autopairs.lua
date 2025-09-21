return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		local autopairs = require("nvim-autopairs")

		autopairs.setup({
			check_ts = true, -- enable treesitter
			ts_config = {
				lua = { "string", "source" },
				javascript = { "string", "template_string" },
				java = false,
			},
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
			disable_in_macro = false,
			disable_in_visualblock = false,
			disable_in_replace_mode = true,
			ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
			enable_moveright = true,
			enable_afterquote = true,
			enable_check_bracket_line = true,
			enable_bracket_in_quote = true,
			enable_abbr = false,
			break_undo = true,
			map_cr = true,
			map_bs = true,
			map_c_h = false,
			map_c_w = false,
		})

		-- Integration with blink.cmp
		local blink_cmp = require("blink.cmp")

		-- Add comma completion for arrays/objects
		local Rule = require("nvim-autopairs.rule")
		local cond = require("nvim-autopairs.conds")


		-- Custom completion handler for blink.cmp
		blink_cmp.setup({
			completion = {
				accept = {
					auto_brackets = {
						enabled = true,
					},
				},
			},
		})
	end,
}
