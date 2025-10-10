return {
	"ray-x/go.nvim",
	dependencies = {
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	event = { "CmdlineEnter" },
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()',
	opts = {
		goimports = "gopls",
		fillstruct = "gopls",
		build_tags = "",
		textobjects = true,
		test_runner = "go",
		verbose_tests = true,
		run_in_floaterm = false,
		trouble = true,
		luasnip = false,
		lsp_keymaps = false,
		lsp_codelens = true,
		diagnostic = {
			hdlr = false,
			underline = true,
			virtual_text = { space = 0, prefix = "■" },
			signs = true,
			update_in_insert = false,
		},
		lsp_document_formatting = false,
		lsp_inlay_hints = {
			enable = true,
			style = "inlay",
		},
		gopls_cmd = nil,
		gopls_remote_auto = true,
		lsp_cfg = false, -- Use our lsp.lua config instead
	},
	config = function(_, opts)
		require("go").setup(opts)

		-- Go-specific keymaps
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "go",
			callback = function(ev)
				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = "Go: " .. desc })
				end

				-- Code generation
				map("n", "<leader>cgs", "<cmd>GoFillStruct<cr>", "Fill struct")
				map("n", "<leader>cge", "<cmd>GoIfErr<cr>", "Add if err")
				map("n", "<leader>cgi", "<cmd>GoImpl<cr>", "Implement interface")
				map("n", "<leader>cgc", "<cmd>GoCmt<cr>", "Add comment")

				-- Testing
				map("n", "<leader>ctt", "<cmd>GoTest<cr>", "Run tests")
				map("n", "<leader>ctf", "<cmd>GoTestFunc<cr>", "Test function")
				map("n", "<leader>ctp", "<cmd>GoTestPkg<cr>", "Test package")
				map("n", "<leader>cta", "<cmd>GoAddTest<cr>", "Add test")
				map("n", "<leader>ctA", "<cmd>GoAddAllTest<cr>", "Add all tests")
				map("n", "<leader>ctc", "<cmd>GoCoverage<cr>", "Coverage")
				map("n", "<leader>ctC", "<cmd>GoCoverage -t<cr>", "Coverage toggle")

				-- Build and run
				map("n", "<leader>cbr", "<cmd>GoRun<cr>", "Run")
				map("n", "<leader>cbb", "<cmd>GoBuild<cr>", "Build")
				map("n", "<leader>cbs", "<cmd>GoStop<cr>", "Stop")

				-- Go tools
				map("n", "<leader>cmi", "<cmd>GoModInit<cr>", "Mod init")
				map("n", "<leader>cmt", "<cmd>GoModTidy<cr>", "Mod tidy")
				map("n", "<leader>cmg", "<cmd>GoGet<cr>", "Go get")

				-- Linting and formatting
				map("n", "<leader>clf", "<cmd>GoFmt<cr>", "Format")
				map("n", "<leader>cli", "<cmd>GoImports<cr>", "Imports")
				map("n", "<leader>clv", "<cmd>GoVet<cr>", "Vet")
				map("n", "<leader>cll", "<cmd>GoLint<cr>", "Lint")

				-- Navigation
				map("n", "<leader>cnd", "<cmd>GoDoc<cr>", "Go doc")
				map("n", "<leader>cni", "<cmd>GoInfo<cr>", "Go info")

				-- Struct tags
				map("n", "<leader>cst", "<cmd>GoAddTag<cr>", "Add struct tags")
				map("n", "<leader>csr", "<cmd>GoRmTag<cr>", "Remove struct tags")
				map("n", "<leader>csc", "<cmd>GoClearTag<cr>", "Clear struct tags")

				-- Alternate file
				map("n", "<leader>cA", "<cmd>GoAlt<cr>", "Alternate file")
				map("n", "<leader>cV", "<cmd>GoAltV<cr>", "Alternate file (vertical)")
				map("n", "<leader>cS", "<cmd>GoAltS<cr>", "Alternate file (horizontal)")
			end,
		})
	end,
}
