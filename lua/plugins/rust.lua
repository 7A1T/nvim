return {
	"mrcjkb/rustaceanvim",
	version = "^5",
	lazy = false,
	ft = { "rust" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"mfussenegger/nvim-dap",
	},
	config = function()
		vim.g.rustaceanvim = {
			-- Plugin configuration
			tools = {
				-- Hover actions
				hover_actions = {
					auto_focus = true,
				},
				-- Inlay hints
				inlay_hints = {
					auto = true,
					show_parameter_hints = true,
					parameter_hints_prefix = "<- ",
					other_hints_prefix = "=> ",
				},
			},
			-- LSP configuration
			server = {
				on_attach = function(client, bufnr)
					-- Rust-specific keymaps will be set below
				end,
				default_settings = {
					-- rust-analyzer language server configuration
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							buildScripts = {
								enable = true,
							},
						},
						-- Add clippy lints for Rust.
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
			-- DAP configuration
			dap = {
				adapter = {
					type = "executable",
					command = "lldb-vscode",
					name = "rt_lldb",
				},
			},
		}

		-- Auto-format on save using rustfmt
		local format_sync_grp = vim.api.nvim_create_augroup("RustFormat", {})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.rs",
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
			group = format_sync_grp,
		})

		-- Rust-specific keymaps (only active for Rust files)
		local function rust_keymap(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = true, desc = "Rust: " .. desc })
		end

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "rust",
			callback = function()
				-- Code actions and refactoring
				rust_keymap("n", "<leader>cra", function()
					vim.cmd.RustLsp("codeAction")
				end, "Code action")
				rust_keymap("n", "<leader>crr", function()
					vim.cmd.RustLsp("runnables")
				end, "Runnables")
				rust_keymap("n", "<leader>crd", function()
					vim.cmd.RustLsp("debuggables")
				end, "Debuggables")

				-- Testing
				rust_keymap("n", "<leader>ctt", function()
					vim.cmd.RustLsp({ "testables", bang = true })
				end, "Run tests")
				rust_keymap("n", "<leader>ctf", function()
					vim.cmd.RustLsp("testables")
				end, "Test function")

				-- Build and run
				rust_keymap("n", "<leader>cbr", function()
					vim.cmd.RustLsp("run")
				end, "Run")
				rust_keymap("n", "<leader>cbb", ":!cargo build<CR>", "Build")
				rust_keymap("n", "<leader>cbc", ":!cargo check<CR>", "Check")
				rust_keymap("n", "<leader>cbC", ":!cargo clippy<CR>", "Clippy")

				-- Debugging
				rust_keymap("n", "<leader>cdt", function()
					vim.cmd.RustLsp("debuggables")
				end, "Debug")

				-- Cargo commands
				rust_keymap("n", "<leader>cmi", ":!cargo init<CR>", "Cargo init")
				rust_keymap("n", "<leader>cmn", ":!cargo new ", "Cargo new")
				rust_keymap("n", "<leader>cma", ":!cargo add ", "Cargo add")
				rust_keymap("n", "<leader>cmu", ":!cargo update<CR>", "Cargo update")
				rust_keymap("n", "<leader>cmb", ":!cargo bench<CR>", "Cargo bench")

				-- Linting and formatting
				rust_keymap("n", "<leader>clf", function()
					vim.lsp.buf.format({ async = true })
				end, "Format")
				rust_keymap("n", "<leader>cll", ":!cargo clippy<CR>", "Clippy")

				-- Navigation and information
				rust_keymap("n", "<leader>cnd", function()
					vim.cmd.RustLsp({ "openDocs", bang = true })
				end, "Open docs")
				rust_keymap("n", "<leader>cnD", function()
					vim.cmd.RustLsp("openCargo")
				end, "Open Cargo.toml")
				rust_keymap("n", "<leader>cnp", function()
					vim.cmd.RustLsp("parentModule")
				end, "Parent module")
				rust_keymap("n", "<leader>cnj", function()
					vim.cmd.RustLsp("joinLines")
				end, "Join lines")

				-- Hover and explanations
				rust_keymap("n", "<leader>cnh", function()
					vim.cmd.RustLsp({ "hover", "actions" })
				end, "Hover actions")
				rust_keymap("n", "<leader>cne", function()
					vim.cmd.RustLsp("explainError")
				end, "Explain error")

				-- Structural search and replace
				rust_keymap("n", "<leader>css", function()
					vim.cmd.RustLsp("ssr")
				end, "Structural search replace")

				-- Crate graph and dependencies
				rust_keymap("n", "<leader>cgv", function()
					vim.cmd.RustLsp("crateGraph")
				end, "View crate graph")

				-- Macro expansion
				rust_keymap("n", "<leader>cem", function()
					vim.cmd.RustLsp("expandMacro")
				end, "Expand macro")

				-- Move item up/down
				rust_keymap("n", "<leader>cmu", function()
					vim.cmd.RustLsp("moveItem")
				end, "Move item up")
				rust_keymap("n", "<leader>cmd", function()
					vim.cmd.RustLsp("moveItem")
				end, "Move item down")
			end,
		})
	end,
}