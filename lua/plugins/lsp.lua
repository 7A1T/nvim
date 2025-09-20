return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim",       opts = {} },
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function()
		---------------------------------------------------------------------------
		-- 1. Diagnostic Configuration
		---------------------------------------------------------------------------
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "✘",
					[vim.diagnostic.severity.WARN] = "▲",
					[vim.diagnostic.severity.HINT] = "⚑",
					[vim.diagnostic.severity.INFO] = "»",
				},
			},
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "●",
			},
			severity_sort = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		---------------------------------------------------------------------------
		-- 2. Enhanced Capabilities with Folding Support
		---------------------------------------------------------------------------
		local capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		)

		-- Enable folding capabilities
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		-- LSP keymaps and autocmds are now handled in core/autocmds.lua

		---------------------------------------------------------------------------
		-- 4. Enhanced Server Configurations
		---------------------------------------------------------------------------
		local servers = {
			-- C/C++
			clangd = {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders",
					"--fallback-style=llvm",
				},
				init_options = {
					usePlaceholders = true,
					completeUnimported = true,
					clangdFileStatus = true,
				},
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
			},

			-- TypeScript/JavaScript
			ts_ls = {
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
			},

			-- Python
			ruff = {},
			pylsp = {
				settings = {
					pylsp = {
						plugins = {
							pyflakes = { enabled = false },
							pycodestyle = { enabled = false },
							autopep8 = { enabled = false },
							yapf = { enabled = false },
							mccabe = { enabled = false },
							pylsp_mypy = { enabled = false },
							pylsp_black = { enabled = false },
							pylsp_isort = { enabled = false },
						},
					},
				},
			},

			-- Web Technologies
			html = {
				filetypes = { "html", "twig", "hbs", "templ" },
				settings = {
					html = {
						format = {
							templating = true,
							wrapLineLength = 120,
							wrapAttributes = "auto",
						},
						hover = {
							documentation = true,
							references = true,
						},
					},
				},
			},
			cssls = {
				settings = {
					css = {
						validate = true,
						lint = {
							unknownAtRules = "ignore",
						},
					},
					scss = { validate = true },
					less = { validate = true },
				},
			},
			tailwindcss = {
				settings = {
					tailwindCSS = {
						experimental = {
							classRegex = {
								"tw`([^`]*)",
								'tw="([^"]*)',
								'tw={"([^"}]*)',
								"tw\\.\\w+`([^`]*)",
								"tw\\(.*?\\)`([^`]*)",
							},
						},
					},
				},
			},

			-- DevOps & Config
			dockerls = {},
			sqlls = {},
			terraformls = {},
			jsonls = {
				settings = {
					json = {
						validate = { enable = true },
						format = { enable = true },
					},
				},
			},
			yamlls = {
				settings = {
					yaml = {
						validate = true,
						hover = true,
						completion = true,
						format = { enable = true },
					},
				},
			},

			-- Go
			gopls = {
				settings = {
					gopls = {
						gofumpt = true,
						codelenses = {
							gc_details = false,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						analyses = {
							fieldalignment = true,
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
						},
						usePlaceholders = true,
						completeUnimported = true,
						staticcheck = true,
						directoryFilters = {
							"-.git",
							"-.vscode",
							"-.idea",
							"-.vscode-test",
							"-node_modules",
						},
						semanticTokens = true,
					},
				},
			},

			-- Lua
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
							keywordSnippet = "Replace",
						},
						runtime = {
							version = "LuaJIT",
							pathStrict = true,
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								"${3rd}/luv/library",
								"${3rd}/busted/library",
							},
						},
						diagnostics = {
							disable = { "missing-fields" },
							globals = { "vim" },
							unusedLocalExclude = { "_*" },
						},
						format = { enable = false },
						hint = {
							enable = true,
							arrayIndex = "Disable",
						},
					},
				},
			},
		}

		---------------------------------------------------------------------------
		-- 5. Mason Setup with Enhanced Tool Management
		---------------------------------------------------------------------------
		require("mason").setup({
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		local ensure_installed = vim.tbl_keys(servers)
		vim.list_extend(ensure_installed, {
			"stylua",
			"prettier",
			"shfmt",
			"goimports",
			"gofumpt",
		})

		require("mason-tool-installer").setup({
			ensure_installed = ensure_installed,
			auto_update = false,
			run_on_start = true,
		})

		---------------------------------------------------------------------------
		-- 6. Mason-LSPConfig Setup with Enhanced Handlers
		---------------------------------------------------------------------------
		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(servers),
			automatic_installation = true,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})

					-- Enhanced gopls setup
					if server_name == "gopls" then
						local orig_on_attach = server.on_attach
						server.on_attach = function(client, bufnr)
							-- Workaround for gopls semanticTokens bug
							if not client.server_capabilities.semanticTokensProvider then
								local semantic = client.config.capabilities.textDocument.semanticTokens
								if semantic then
									client.server_capabilities.semanticTokensProvider = {
										full = true,
										legend = {
											tokenTypes = semantic.tokenTypes,
											tokenModifiers = semantic.tokenModifiers,
										},
										range = true,
									}
								end
							end

							-- Enable inlay hints by default for Go
							if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
								vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
							end

							if orig_on_attach then
								orig_on_attach(client, bufnr)
							end
						end
					end

					-- Enhanced TypeScript setup
					if server_name == "ts_ls" then
						server.on_attach = function(client, bufnr)
							-- Enable inlay hints by default for TypeScript
							if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
								vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
							end
						end
					end

					require("lspconfig")[server_name].setup(server)
				end,
			},
		})

		---------------------------------------------------------------------------
		-- 7. Global LSP Configuration
		---------------------------------------------------------------------------
		-- Set up border for LspInfo
		require("lspconfig.ui.windows").default_options.border = "rounded"

		-- Configure hover window
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
		})

		-- Configure signature help window
		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = "rounded",
		})
	end,
}
