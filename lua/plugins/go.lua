return {
	"ray-x/go.nvim",
	dependencies = {
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		goimports = "gopls", -- use gopls for goimports (faster)
		fillstruct = "gopls", -- use gopls for fillstruct
		-- dap_debug = true, -- enable dap debug
		-- dap_debug_keymap = false, -- disable default dap keymaps (we'll define our own)
		-- dap_debug_gui = true, -- enable dap-ui
		-- dap_debug_vt = true, -- enable dap virtual text
		build_tags = "", -- set build tags
		textobjects = true, -- enable textobjects
		test_runner = "go", -- richgo, go test, richgo, dlv, ginkgo
		verbose_tests = true, -- add verbose flag to tests
		run_in_floaterm = false, -- run in built-in terminal
		trouble = true, -- enable trouble integration
		luasnip = false, -- disable luasnip (using blink.cmp snippets)
		lsp_keymaps = false, -- disable default lsp keymaps (we'll define our own)
		lsp_codelens = true, -- enable codelens
		diagnostic = { -- diagnostic options
			hdlr = false, -- hook lsp diag handler
			underline = true,
			virtual_text = { space = 0, prefix = "■" },
			signs = true,
			update_in_insert = false,
		},
		lsp_document_formatting = false, -- use null-ls for formatting
		lsp_inlay_hints = {
			enable = true,
			style = "inlay",
		},
		gopls_cmd = nil, -- use default gopls
		gopls_remote_auto = true,
		lsp_cfg = true,
	},
	config = function(_, opts)
		require("go").setup(opts)

		-- -- Auto-format on save
		-- local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
		-- vim.api.nvim_create_autocmd("BufWritePre", {
		-- 	pattern = "*.go",
		-- 	callback = function()
		-- 		require("go.format").goimports()
		-- 	end,
		-- 	group = format_sync_grp,
		-- })

		-- Go-specific keymaps (only active for Go files)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "go",
			callback = function(ev)
				local function go_keymap(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = "Go: " .. desc })
				end

				-- Code generation and manipulation
				go_keymap("n", "<leader>cgs", "<cmd>GoFillStruct<cr>", "Fill struct")
				go_keymap("n", "<leader>cge", "<cmd>GoIfErr<cr>", "Add if err")
				go_keymap("n", "<leader>cgr", "<cmd>GoFixPlurals<cr>", "Fix plurals")
				go_keymap("n", "<leader>cgi", "<cmd>GoImpl<cr>", "Implement interface")
				go_keymap("n", "<leader>cgc", "<cmd>GoCmt<cr>", "Add comment")

				-- Testing
				go_keymap("n", "<leader>ctt", "<cmd>GoTest<cr>", "Run tests")
				go_keymap("n", "<leader>ctf", "<cmd>GoTestFunc<cr>", "Test function")
				go_keymap("n", "<leader>ctp", "<cmd>GoTestPkg<cr>", "Test package")
				go_keymap("n", "<leader>cta", "<cmd>GoAddTest<cr>", "Add test")
				go_keymap("n", "<leader>ctA", "<cmd>GoAddAllTest<cr>", "Add all tests")
				go_keymap("n", "<leader>ctc", "<cmd>GoCoverage<cr>", "Coverage")
				go_keymap("n", "<leader>ctC", "<cmd>GoCoverage -t<cr>", "Coverage toggle")

				-- Build and run
				go_keymap("n", "<leader>cbr", "<cmd>GoRun<cr>", "Run")
				go_keymap("n", "<leader>cbb", "<cmd>GoBuild<cr>", "Build")
				go_keymap("n", "<leader>cbs", "<cmd>GoStop<cr>", "Stop")
				go_keymap("n", "<leader>cbR", "<cmd>GoRestart<cr>", "Restart")

				-- Debugging
				-- go_keymap("n", "<leader>cdt", "<cmd>GoDebug -t<cr>", "Debug test")
				-- go_keymap("n", "<leader>cdr", "<cmd>GoDebug<cr>", "Debug")
				-- go_keymap("n", "<leader>cds", "<cmd>GoDbgStop<cr>", "Debug stop")

				-- Go tools
				go_keymap("n", "<leader>cmi", "<cmd>GoModInit<cr>", "Mod init")
				go_keymap("n", "<leader>cmt", "<cmd>GoModTidy<cr>", "Mod tidy")
				go_keymap("n", "<leader>cmv", "<cmd>GoModVendor<cr>", "Mod vendor")
				go_keymap("n", "<leader>cmg", "<cmd>GoGet<cr>", "Go get")

				-- Linting and formatting
				go_keymap("n", "<leader>clf", "<cmd>GoFmt<cr>", "Format")
				go_keymap("n", "<leader>cli", "<cmd>GoImports<cr>", "Imports")
				go_keymap("n", "<leader>clv", "<cmd>GoVet<cr>", "Vet")
				go_keymap("n", "<leader>cll", "<cmd>GoLint<cr>", "Lint")

				-- Navigation and information
				go_keymap("n", "<leader>cnd", "<cmd>GoDoc<cr>", "Go doc")
				go_keymap("n", "<leader>cnD", "<cmd>GoDocBrowser<cr>", "Go doc browser")
				go_keymap("n", "<leader>cnr", "<cmd>GoRename<cr>", "Rename")
				go_keymap("n", "<leader>cni", "<cmd>GoInfo<cr>", "Go info")

				-- Struct tags
				go_keymap("n", "<leader>cst", "<cmd>GoAddTag<cr>", "Add struct tags")
				go_keymap("n", "<leader>csr", "<cmd>GoRmTag<cr>", "Remove struct tags")
				go_keymap("n", "<leader>csc", "<cmd>GoClearTag<cr>", "Clear struct tags")

				-- Alternate file (test <-> implementation)
				go_keymap("n", "<leader>cA", "<cmd>GoAlt<cr>", "Alternate file")
				go_keymap("n", "<leader>cV", "<cmd>GoAltV<cr>", "Alternate file (vertical)")
				go_keymap("n", "<leader>cS", "<cmd>GoAltS<cr>", "Alternate file (horizontal)")
			end,
		})
	end,
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()',
}
