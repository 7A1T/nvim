-- =============================================================================
-- AUTOCMDS.LUA - Centralized Autocmd Configuration
-- =============================================================================

-- ===================================================================
-- DATABASE COMPLETION (vim-dadbod)
-- ===================================================================
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "sql", "mysql", "plsql" },
	callback = function()
		require("cmp").setup.buffer({
			sources = {
				{ name = "vim-dadbod-completion" },
				{ name = "buffer" },
			},
		})
	end,
	desc = "Setup database completion for SQL files",
})

-- ===================================================================
-- NULL-LS FORMATTING
-- ===================================================================
local null_ls_augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("null-ls-attach", { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if not client then
			return
		end

		-- Only setup formatting autocmd for null-ls or formatters
		if client.name == "null-ls" and client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = null_ls_augroup, buffer = event.buf })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = null_ls_augroup,
				buffer = event.buf,
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
				desc = "Format on save with null-ls",
			})
		end
	end,
	desc = "Setup null-ls formatting on attach",
})

-- ===================================================================
-- LSP CONFIGURATION
-- ===================================================================
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if not client then
			return
		end

		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, {
				buffer = event.buf,
				desc = "LSP: " .. desc,
				silent = true,
			})
		end

		-- Code actions and refactoring (buffer-specific)
		map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
		map("<leader>rn", vim.lsp.buf.rename, "Rename")

		-- Format with null-ls fallback
		map("<leader>bf", function()
			vim.lsp.buf.format({
				async = true,
				filter = function(format_client)
					-- Prefer null-ls for formatting
					return format_client.name ~= "tsserver" and format_client.name ~= "lua_ls"
				end,
			})
		end, "Format")

		-- Hover and signature help
		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation", "i")

		-- Diagnostics (navigation keymaps are in keymaps.lua)
		map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
		map("]d", vim.diagnostic.goto_next, "Next Diagnostic")

		-- Workspace management
		map("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
		map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")
		map("<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "List Workspace Folders")

		-- Document highlighting
		if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
			local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
				desc = "Highlight references under cursor",
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
				desc = "Clear reference highlights",
			})
		end

		-- Inlay hints (Neovim 0.10+)
		if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(
					not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }),
					{ bufnr = event.buf }
				)
			end, "Toggle Inlay Hints")
		end

		-- Code lens (refresh on save)
		if client.supports_method(vim.lsp.protocol.Methods.textDocument_codeLens) then
			map("<leader>cl", vim.lsp.codelens.run, "Run Code Lens")
			vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
				buffer = event.buf,
				callback = vim.lsp.codelens.refresh,
				desc = "Refresh code lens",
			})
		end
	end,
	desc = "Setup LSP keymaps and features on attach",
})

-- LSP Detach cleanup
vim.api.nvim_create_autocmd("LspDetach", {
	group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
	callback = function(event)
		vim.lsp.buf.clear_references()
		vim.api.nvim_clear_autocmds({
			group = "lsp-highlight",
			buffer = event.buf,
		})
	end,
	desc = "Cleanup LSP features on detach",
})

-- ===================================================================
-- SNACKS.NVIM SETUP
-- ===================================================================
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		-- Setup some globals for debugging (lazy-loaded)
		_G.dd = function(...)
			Snacks.debug.inspect(...)
		end
		_G.bt = function()
			Snacks.debug.backtrace()
		end

		-- Override print to use snacks for `:=` command
		if vim.fn.has("nvim-0.11") == 1 then
			vim._print = function(_, ...)
				dd(...)
			end
		else
			vim.print = _G.dd
		end

		-- Create some toggle mappings
		Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
		Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
		Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
		Snacks.toggle.diagnostics():map("<leader>ud")
		Snacks.toggle.line_number():map("<leader>ul")
		Snacks.toggle
			.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
			:map("<leader>uc")
		Snacks.toggle.treesitter():map("<leader>uT")
		Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
		Snacks.toggle.inlay_hints():map("<leader>uh")
		Snacks.toggle.indent():map("<leader>ug")
		Snacks.toggle.dim():map("<leader>uD")
	end,
	desc = "Setup Snacks toggle mappings and debugging utilities",
})

-- ===================================================================
-- GENERAL AUTOCMDS
-- ===================================================================

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
	desc = "Highlight when yanking text",
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = vim.api.nvim_create_augroup("checktime", { clear = true }),
	command = "checktime",
	desc = "Check if file needs to be reloaded",
})

-- Resize splits if window gets resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = vim.api.nvim_create_augroup("resize-splits", { clear = true }),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
	desc = "Resize splits when window is resized",
})

-- Go to last location when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("last-location", { clear = true }),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_location then
			return
		end
		vim.b[buf].last_location = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
	desc = "Go to last cursor position when opening a buffer",
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("close-with-q", { clear = true }),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
		"dbout",
		"gitsigns.blame",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true, desc = "Quit buffer" })
	end,
	desc = "Close certain filetypes with q",
})

-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("wrap-spell", { clear = true }),
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
	desc = "Enable wrap and spell for text files",
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = vim.api.nvim_create_augroup("auto-create-dir", { clear = true }),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
	desc = "Auto create directory when saving file",
})
