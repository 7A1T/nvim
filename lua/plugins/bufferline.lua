return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"moll/vim-bbye",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				mode = "buffers", -- set to "tabs" to only show tabpages instead
				style_preset = bufferline.style_preset.default,
				themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
				numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
				close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
				right_mouse_command = nil,
				left_mouse_command = nil,
				middle_mouse_command = nil,
				buffer_close_icon = "󰅖",
				modified_icon = "●",
				close_icon = "",
				left_trunc_marker = "",
				right_trunc_marker = "",
				max_name_length = 18,
				max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
				truncate_names = true, -- whether or not tab names should be truncated
				tab_size = 18,
				diagnostics = false,
				custom_filter = function(bufnr)
					-- if the result is false, this buffer will be shown, otherwise, this
					-- buffer will be hidden.

					-- filter out filetypes you don't want to see
					local exclude_ft = { "qf", "fugitive", "git" }
					local cur_ft = vim.bo[bufnr].filetype
					local should_filter = vim.tbl_contains(exclude_ft, cur_ft)

					if should_filter then
						return false
					end

					return true
				end,
				offsets = { { filetype = "NvimTree", text = "EXPLORER", text_align = "center" } },
				color_icons = true,
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				indicator = {
					style = "icon",
					icon = " ",
				},
				show_tab_indicators = true,
				show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
				duplicates_across_groups = false, -- whether to consider duplicate paths in different groups as duplicates
				persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
				separator_style = { "│", "│" }, -- | "thick" | "thin" | { 'any', 'any' },
				enforce_regular_tabs = true,
				always_show_bufferline = true,
				sort_by = "id",
				pick = {
					alphabet = "abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMOPQRSTUVWXYZ1234567890",
				},
			},
			highlights = {
				fill = {
					fg = { attribute = "fg", highlight = "Normal" },
					bg = { attribute = "bg", highlight = "StatusLineNC" },
				},
				background = {
					fg = { attribute = "fg", highlight = "Normal" },
					bg = { attribute = "bg", highlight = "StatusLine" },
				},
				buffer_visible = {
					fg = { attribute = "fg", highlight = "Normal" },
					bg = { attribute = "bg", highlight = "Normal" },
				},
				buffer_selected = {
					fg = { attribute = "fg", highlight = "Normal" },
					bg = { attribute = "bg", highlight = "Normal" },
				},
				separator = {
					fg = { attribute = "bg", highlight = "Normal" },
					bg = { attribute = "bg", highlight = "StatusLine" },
				},
				separator_selected = {
					fg = { attribute = "fg", highlight = "Special" },
					bg = { attribute = "bg", highlight = "Normal" },
				},
				separator_visible = {
					fg = { attribute = "fg", highlight = "Normal" },
					bg = { attribute = "bg", highlight = "StatusLineNC" },
				},
				close_button = {
					fg = { attribute = "fg", highlight = "Normal" },
					bg = { attribute = "bg", highlight = "StatusLine" },
				},
				close_button_selected = {
					fg = { attribute = "fg", highlight = "Normal" },
					bg = { attribute = "bg", highlight = "Normal" },
				},
				close_button_visible = {
					fg = { attribute = "fg", highlight = "Normal" },
					bg = { attribute = "bg", highlight = "Normal" },
				},
			},
		})
	end,
}
