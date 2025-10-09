return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio",
			{
				"rcarriga/nvim-dap-ui",
				opts = {},
			},
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},
		},
		keys = {
			{
				"<leader>dB",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "DAP: Toggle Breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "DAP: Continue",
			},
			{
				"<leader>ds",
				function()
					require("dap").step_over()
				end,
				desc = "DAP: Step Over",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "DAP: Step Into",
			},
			{
				"<leader>do",
				function()
					require("dap").step_out()
				end,
				desc = "DAP: Step Out",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.open()
				end,
				desc = "DAP: Open REPL",
			},
			{
				"<leader>dt",
				function()
					require("dap").terminate()
				end,
				desc = "DAP: Terminate",
			},
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "DAP: Toggle UI",
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- DAP UI auto open/close
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"leoluz/nvim-dap-go",
		dependencies = "mfussenegger/nvim-dap",
		keys = {
			{
				"<leader>dgt",
				function()
					require("dap-go").debug_test()
				end,
				desc = "DAP: Debug Go Test",
			},
			{
				"<leader>dgl",
				function()
					require("dap-go").debug_last()
				end,
				desc = "DAP: Debug Last Go Test",
			},
		},
		opts = {},
	},
}
