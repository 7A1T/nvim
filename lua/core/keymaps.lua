-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

-- save file
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", { noremap = true, silent = true, desc = "Save file" })

-- save file without auto-formatting
vim.keymap.set(
	"n",
	"<leader>sn",
	"<cmd>noautocmd w <CR>",
	{ noremap = true, silent = true, desc = "Save without formatting" }
)

-- quit file
vim.keymap.set("n", "<C-q>", "<cmd> q <CR>", { noremap = true, silent = true, desc = "Quit file" })

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true, desc = "Delete char without copying" })

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true, desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true, desc = "Scroll up and center" })

-- Resize with arrows
vim.keymap.set("n", "<Up>", ":resize -2<CR>", { noremap = true, silent = true, desc = "Decrease window height" })
vim.keymap.set("n", "<Down>", ":resize +2<CR>", { noremap = true, silent = true, desc = "Increase window height" })
vim.keymap.set(
	"n",
	"<Left>",
	":vertical resize -2<CR>",
	{ noremap = true, silent = true, desc = "Decrease window width" }
)
vim.keymap.set(
	"n",
	"<Right>",
	":vertical resize +2<CR>",
	{ noremap = true, silent = true, desc = "Increase window width" }
)

-- Window management
vim.keymap.set("n", "<leader>v", "<C-w>v", { noremap = true, silent = true, desc = "Split window vertically" })
vim.keymap.set("n", "<leader>h", "<C-w>s", { noremap = true, silent = true, desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { noremap = true, silent = true, desc = "Make split windows equal" })
vim.keymap.set("n", "<leader>xs", ":close<CR>", { noremap = true, silent = true, desc = "Close current split" })

-- Navigate between splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { noremap = true, silent = true, desc = "Move to window above" })
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { noremap = true, silent = true, desc = "Move to window below" })
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { noremap = true, silent = true, desc = "Move to window left" })
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { noremap = true, silent = true, desc = "Move to window right" })

-- Tabs
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", { noremap = true, silent = true, desc = "Open new tab" })
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", { noremap = true, silent = true, desc = "Close current tab" })
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", { noremap = true, silent = true, desc = "Go to next tab" })
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", { noremap = true, silent = true, desc = "Go to previous tab" })

-- Toggle line wrapping
vim.keymap.set(
	"n",
	"<leader>lw",
	"<cmd>set wrap!<CR>",
	{ noremap = true, silent = true, desc = "Toggle line wrapping" }
)

-- Folding
vim.keymap.set("n", "zR", "zR", { desc = "Open all folds" })
vim.keymap.set("n", "zM", "zM", { desc = "Close all folds" })
vim.keymap.set("n", "zr", "zr", { desc = "Reduce fold level" })
vim.keymap.set("n", "zm", "zm", { desc = "Increase fold level" })
vim.keymap.set("n", "za", "za", { desc = "Toggle fold under cursor" })
vim.keymap.set("n", "zo", "zo", { desc = "Open fold under cursor" })
vim.keymap.set("n", "zc", "zc", { desc = "Close fold under cursor" })
vim.keymap.set("n", "zj", "zj", { desc = "Move to next fold" })
vim.keymap.set("n", "zk", "zk", { desc = "Move to previous fold" })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true, desc = "Decrease indent and stay in visual" })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true, desc = "Increase indent and stay in visual" })

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', { noremap = true, silent = true, desc = "Paste without overwriting register" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- ===================================================================
-- DEBUGGING (DAP)
-- ===================================================================
vim.keymap.set("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end, { desc = "DAP: Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", function()
	require("dap").continue()
end, { desc = "DAP: Continue" })
vim.keymap.set("n", "<leader>ds", function()
	require("dap").step_over()
end, { desc = "DAP: Step Over" })
vim.keymap.set("n", "<leader>di", function()
	require("dap").step_into()
end, { desc = "DAP: Step Into" })
vim.keymap.set("n", "<leader>do", function()
	require("dap").step_out()
end, { desc = "DAP: Step Out" })
vim.keymap.set("n", "<leader>dr", function()
	require("dap").repl.open()
end, { desc = "DAP: Open REPL" })
vim.keymap.set("n", "<leader>dt", function()
	require("dap").terminate()
end, { desc = "DAP: Terminate" })
vim.keymap.set("n", "<leader>du", function()
	require("dapui").toggle()
end, { desc = "DAP: Toggle UI" })

-- Go-specific debugging
vim.keymap.set("n", "<leader>dgt", function()
	require("dap-go").debug_test()
end, { desc = "DAP: Debug Go Test" })
vim.keymap.set("n", "<leader>dgl", function()
	require("dap-go").debug_last()
end, { desc = "DAP: Debug Last Go Test" })

-- ===================================================================
-- TESTING (Neotest)
-- ===================================================================
vim.keymap.set("n", "<leader>trn", function()
	require("neotest").run.run()
end, { desc = "Test: Run Nearest" })
vim.keymap.set("n", "<leader>trf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Test: Run File" })
vim.keymap.set("n", "<leader>trs", function()
	require("neotest").summary.toggle()
end, { desc = "Test: Toggle Summary" })
vim.keymap.set("n", "<leader>tro", function()
	require("neotest").output.open()
end, { desc = "Test: Open Output" })
vim.keymap.set("n", "<leader>trp", function()
	require("neotest").output_panel.toggle()
end, { desc = "Test: Toggle Output Panel" })
vim.keymap.set("n", "<leader>trw", function()
	require("neotest").watch.toggle(vim.fn.expand("%"))
end, { desc = "Test: Toggle Watch" })

-- ===================================================================
-- COMMENT.NVIM
-- ===================================================================
vim.keymap.set("n", "<C-_>", function()
	require("Comment.api").toggle.linewise.current()
end, { desc = "Comment: Toggle line" })
vim.keymap.set(
	"v",
	"<C-_>",
	"<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
	{ desc = "Comment: Toggle selection" }
)

-- ===================================================================
-- DATABASE (vim-dadbod)
-- ===================================================================
vim.keymap.set("n", "<leader>dbu", "<cmd>DBUIToggle<cr>", { desc = "Database: Toggle UI" })
vim.keymap.set("n", "<leader>dbf", "<cmd>DBUIFindBuffer<cr>", { desc = "Database: Find Buffer" })
vim.keymap.set("n", "<leader>dbr", "<cmd>DBUIRenameBuffer<cr>", { desc = "Database: Rename Buffer" })
vim.keymap.set("n", "<leader>dbl", "<cmd>DBUILastQueryInfo<cr>", { desc = "Database: Last Query Info" })

-- ===================================================================
-- TROUBLE.NVIM
-- ===================================================================
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>xX",
	"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	{ desc = "Buffer Diagnostics (Trouble)" }
)
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>cl",
	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "LSP Definitions / references / ... (Trouble)" }
)
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-- ===================================================================
-- SNACKS.NVIM (File/Buffer/Search Operations)
-- ===================================================================

-- Core navigation and file operations
vim.keymap.set("n", "<leader><space>", function()
	Snacks.picker.smart()
end, { desc = "Smart Find Files" })
vim.keymap.set("n", "<leader>e", function()
	Snacks.explorer()
end, { desc = "File Explorer" })

-- Find operations
vim.keymap.set("n", "<leader>fb", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fc", function()
	Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Config File" })
vim.keymap.set("n", "<leader>ff", function()
	Snacks.picker.files()
end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", function()
	Snacks.picker.git_files()
end, { desc = "Find Git Files" })
vim.keymap.set("n", "<leader>fp", function()
	Snacks.picker.projects()
end, { desc = "Projects" })
vim.keymap.set("n", "<leader>fr", function()
	Snacks.picker.recent()
end, { desc = "Recent" })

-- Git operations
vim.keymap.set("n", "<leader>gb", function()
	Snacks.git.blame_line()
end, { desc = "Git Blame Line" })
vim.keymap.set("n", "<leader>gB", function()
	Snacks.picker.git_branches()
end, { desc = "Git Branches" })
vim.keymap.set("n", "<leader>gl", function()
	Snacks.picker.git_log()
end, { desc = "Git Log" })
vim.keymap.set("n", "<leader>gL", function()
	Snacks.picker.git_log_line()
end, { desc = "Git Log Line" })
vim.keymap.set("n", "<leader>gs", function()
	Snacks.picker.git_status()
end, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gS", function()
	Snacks.picker.git_stash()
end, { desc = "Git Stash" })
vim.keymap.set("n", "<leader>gd", function()
	Snacks.picker.git_diff()
end, { desc = "Git Diff (Hunks)" })
vim.keymap.set("n", "<leader>gf", function()
	Snacks.picker.git_log_file()
end, { desc = "Git Log File" })
vim.keymap.set({ "n", "v" }, "<leader>gw", function()
	Snacks.gitbrowse()
end, { desc = "Git Browse" })
vim.keymap.set("n", "<leader>gg", function()
	Snacks.lazygit()
end, { desc = "Lazygit" })

-- Search operations
vim.keymap.set("n", "<leader>sb", function()
	Snacks.picker.lines()
end, { desc = "Buffer Lines" })
vim.keymap.set("n", "<leader>sB", function()
	Snacks.picker.grep_buffers()
end, { desc = "Grep Open Buffers" })
vim.keymap.set("n", "<leader>sg", function()
	Snacks.picker.grep()
end, { desc = "Grep" })
vim.keymap.set("n", "<leader>sw", function()
	Snacks.picker.grep_word()
end, { desc = "Visual selection or word" })
vim.keymap.set("x", "<leader>sw", function()
	Snacks.picker.grep_word()
end, { desc = "Visual selection or word" })

-- Advanced search
vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
	desc = "Toggle Spectre",
})
vim.keymap.set("n", '<leader>s"', function()
	Snacks.picker.registers()
end, { desc = "Registers" })
vim.keymap.set("n", "<leader>s/", function()
	Snacks.picker.search_history()
end, { desc = "Search History" })
vim.keymap.set("n", "<leader>sa", function()
	Snacks.picker.autocmds()
end, { desc = "Autocmds" })
vim.keymap.set("n", "<leader>sc", function()
	Snacks.picker.command_history()
end, { desc = "Command History" })
vim.keymap.set("n", "<leader>sC", function()
	Snacks.picker.commands()
end, { desc = "Commands" })
vim.keymap.set("n", "<leader>sd", function()
	Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>sD", function()
	Snacks.picker.diagnostics_buffer()
end, { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>sh", function()
	Snacks.picker.help()
end, { desc = "Help Pages" })
vim.keymap.set("n", "<leader>sH", function()
	Snacks.picker.highlights()
end, { desc = "Highlights" })
vim.keymap.set("n", "<leader>si", function()
	Snacks.picker.icons()
end, { desc = "Icons" })
vim.keymap.set("n", "<leader>sj", function()
	Snacks.picker.jumps()
end, { desc = "Jumps" })
vim.keymap.set("n", "<leader>sk", function()
	Snacks.picker.keymaps()
end, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>sl", function()
	Snacks.picker.loclist()
end, { desc = "Location List" })
vim.keymap.set("n", "<leader>sm", function()
	Snacks.picker.marks()
end, { desc = "Marks" })
vim.keymap.set("n", "<leader>sM", function()
	Snacks.picker.man()
end, { desc = "Man Pages" })
vim.keymap.set("n", "<leader>sp", function()
	Snacks.picker.lazy()
end, { desc = "Search for Plugin Spec" })
vim.keymap.set("n", "<leader>sq", function()
	Snacks.picker.qflist()
end, { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>sR", function()
	Snacks.picker.resume()
end, { desc = "Resume" })
vim.keymap.set("n", "<leader>su", function()
	Snacks.picker.undo()
end, { desc = "Undo History" })

-- LSP operations (via Snacks picker)
vim.keymap.set("n", "gd", function()
	Snacks.picker.lsp_definitions()
end, { desc = "Goto Definition" })
vim.keymap.set("n", "gD", function()
	Snacks.picker.lsp_declarations()
end, { desc = "Goto Declaration" })
vim.keymap.set("n", "gr", function()
	Snacks.picker.lsp_references()
end, { desc = "References", nowait = true })
vim.keymap.set("n", "gI", function()
	Snacks.picker.lsp_implementations()
end, { desc = "Goto Implementation" })
vim.keymap.set("n", "gy", function()
	Snacks.picker.lsp_type_definitions()
end, { desc = "Goto T[y]pe Definition" })
vim.keymap.set("n", "<leader>ss", function()
	Snacks.picker.lsp_symbols()
end, { desc = "LSP Symbols" })
vim.keymap.set("n", "<leader>sS", function()
	Snacks.picker.lsp_workspace_symbols()
end, { desc = "LSP Workspace Symbols" })

-- UI and utility operations
vim.keymap.set("n", "<leader>uC", function()
	Snacks.picker.colorschemes()
end, { desc = "Colorschemes" })
vim.keymap.set("n", "<leader>z", function()
	Snacks.zen()
end, { desc = "Toggle Zen Mode" })
vim.keymap.set("n", "<leader>.", function()
	Snacks.scratch()
end, { desc = "Toggle Scratch Buffer" })
vim.keymap.set("n", "<leader>n", function()
	Snacks.notifier.show_history()
end, { desc = "Notification History" })
vim.keymap.set("n", "<leader>un", function()
	Snacks.notifier.hide()
end, { desc = "Dismiss All Notifications" })

-- Buffer operations
vim.keymap.set("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>ba", function()
	Snacks.bufdelete.other()
end, { desc = "Delete all other buffers" })

-- File operations
vim.keymap.set("n", "<leader>rf", function()
	Snacks.rename.rename_file()
end, { desc = "Rename File" })

-- Terminal
vim.keymap.set("n", "<c-/>", function()
	Snacks.terminal()
end, { desc = "Toggle Terminal" })
vim.keymap.set("n", "<c-_>", function()
	Snacks.terminal()
end, { desc = "which_key_ignore" })

-- Word navigation
vim.keymap.set({ "n", "t" }, "]]", function()
	Snacks.words.jump(vim.v.count1)
end, { desc = "Next Reference" })
vim.keymap.set({ "n", "t" }, "[[", function()
	Snacks.words.jump(-vim.v.count1)
end, { desc = "Prev Reference" })

-- -- Neovim news
-- vim.keymap.set("n", "<leader>N", function()
-- 	Snacks.win({
-- 		file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
-- 		width = 0.6,
-- 		height = 0.6,
-- 		wo = {
-- 			spell = false,
-- 			wrap = false,
-- 			signcolumn = "yes",
-- 			statuscolumn = " ",
-- 			conceallevel = 3,
-- 		},
-- 	})
-- end, { desc = "Neovim News" })

-- ===================================================================
-- LSP KEYMAPS (Buffer-specific, set in autocmds.lua on LspAttach)
-- ===================================================================
-- Note: LSP keymaps like K (hover), <leader>ca (code action), <leader>rn (rename)
-- are set via autocmd in autocmds.lua when LSP attaches to avoid conflicts
