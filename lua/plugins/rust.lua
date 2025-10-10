return {
	"mrcjkb/rustaceanvim",
	version = "^5",
	ft = { "rust" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"mfussenegger/nvim-dap",
	},
	init = function()
		vim.g.rustaceanvim = {
			tools = {
				hover_actions = {
					auto_focus = true,
				},
			},
			server = {
				default_settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							buildScripts = {
								enable = true,
							},
						},
						checkOnSave = {
							allFeatures = true,
							command = "clippy",
							extraArgs = { "--no-deps" },
						},
						procMacro = {
							enable = true,
							ignored = {
								["async-trait"] = { "async_trait" },
								["napi-derive"] = { "napi" },
								["async-recursion"] = { "async_recursion" },
							},
						},
					},
				},
			},
			dap = {
				adapter = {
					type = "executable",
					command = "lldb-vscode",
					name = "rt_lldb",
				},
			},
		}
	end,
	config = function()
		-- Auto-format on save using rustfmt
		local format_sync_grp = vim.api.nvim_create_augroup("RustFormat", {})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.rs",
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
			group = format_sync_grp,
		})

		-- Rust-specific keymaps
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "rust",
			callback = function(ev)
				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = "Rust: " .. desc })
				end

				-- Code actions
				map("n", "<leader>cra", function()
					vim.cmd.RustLsp("codeAction")
				end, "Code action")
				map("n", "<leader>crr", function()
					vim.cmd.RustLsp("runnables")
				end, "Runnables")
				map("n", "<leader>crd", function()
					vim.cmd.RustLsp("debuggables")
				end, "Debuggables")

				-- Testing
				map("n", "<leader>ctt", function()
					vim.cmd.RustLsp({ "testables", bang = true })
				end, "Run tests")
				map("n", "<leader>ctf", function()
					vim.cmd.RustLsp("testables")
				end, "Test function")

				-- Build and run
				map("n", "<leader>cbr", function()
					vim.cmd.RustLsp("run")
				end, "Run")
				map("n", "<leader>cbb", ":!cargo build<CR>", "Build")
				map("n", "<leader>cbc", ":!cargo check<CR>", "Check")
				map("n", "<leader>cbC", ":!cargo clippy<CR>", "Clippy")

				-- Cargo commands
				map("n", "<leader>cmi", ":!cargo init<CR>", "Cargo init")
				map("n", "<leader>cmn", ":!cargo new ", "Cargo new")
				map("n", "<leader>cma", ":!cargo add ", "Cargo add")
				map("n", "<leader>cmu", ":!cargo update<CR>", "Cargo update")

				-- Formatting
				map("n", "<leader>clf", function()
					vim.lsp.buf.format({ async = true })
				end, "Format")

				-- Navigation
				map("n", "<leader>cnd", function()
					vim.cmd.RustLsp({ "openDocs", bang = true })
				end, "Open docs")
				map("n", "<leader>cnD", function()
					vim.cmd.RustLsp("openCargo")
				end, "Open Cargo.toml")
				map("n", "<leader>cnp", function()
					vim.cmd.RustLsp("parentModule")
				end, "Parent module")
				map("n", "<leader>cne", function()
					vim.cmd.RustLsp("explainError")
				end, "Explain error")

				-- Structural search
				map("n", "<leader>css", function()
					vim.cmd.RustLsp("ssr")
				end, "Structural search replace")

				-- Crate graph
				map("n", "<leader>cgv", function()
					vim.cmd.RustLsp("crateGraph")
				end, "View crate graph")

				-- Macro expansion
				map("n", "<leader>cem", function()
					vim.cmd.RustLsp("expandMacro")
				end, "Expand macro")
			end,
		})
	end,
}

