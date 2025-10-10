return {
	"williamboman/mason.nvim",
	cmd = "Mason",
	build = ":MasonUpdate",
	opts = {
		ui = { border = "rounded" },
		ensure_installed = {
			-- LSP servers
			"lua-language-server",
			"gopls",
			"rust-analyzer",

			-- Formatters
			"stylua",
			"goimports",
			"gofumpt",
			"prettier",
			"shfmt",

			-- Linters
			"golangci-lint",
			"luacheck",
			"shellcheck",

			-- Debug adapters
			"delve",
		},
	},
	config = function(_, opts)
		require("mason").setup(opts)

		-- Ensure Mason bin is in PATH
		local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
		if not vim.env.PATH:find(mason_bin, 1, true) then
			vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
		end

		-- Auto-install ensure_installed tools
		local mr = require("mason-registry")
		local function ensure_installed()
			for _, tool in ipairs(opts.ensure_installed) do
				if mr.has_package(tool) then
					local p = mr.get_package(tool)
					if not p:is_installed() then
						vim.notify("Installing " .. tool, vim.log.levels.INFO, { title = "Mason" })
						p:install()
					end
				else
					vim.notify("Package not found: " .. tool, vim.log.levels.WARN, { title = "Mason" })
				end
			end
		end

		if mr.refresh then
			mr.refresh(ensure_installed)
		else
			ensure_installed()
		end
	end,
	keys = {
		{ "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
		{
			"<leader>cM",
			function()
				local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
				local in_path = vim.env.PATH:find(mason_bin, 1, true) ~= nil
				print("Mason bin: " .. mason_bin)
				print("In PATH: " .. tostring(in_path))

				-- Check a few tools
				local tools = { "gopls", "stylua", "golangci-lint" }
				print("\nTool status:")
				for _, tool in ipairs(tools) do
					local executable = vim.fn.executable(tool) == 1
					local path = executable and vim.fn.exepath(tool) or "not found"
					print(string.format("  %s: %s", tool, path))
				end
			end,
			desc = "Mason Status",
		},
	},
}
