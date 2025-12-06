-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Resizing windows with arrow keys
local options = { noremap = true, silent = true }

-- Resize window up
vim.api.nvim_set_keymap("n", "<Up>", ":resize -2<CR>", options)

-- Resize window down
vim.api.nvim_set_keymap("n", "<Down>", ":resize +2<CR>", options)

-- Resize window left
vim.api.nvim_set_keymap("n", "<Left>", ":vertical resize -2<CR>", options)

-- Resize window right
vim.api.nvim_set_keymap("n", "<Right>", ":vertical resize +2<CR>", options)

vim.api.nvim_create_user_command("Cppath", function()
  local full_path = vim.fn.expand("%:p:h")
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]

  if vim.v.shell_error ~= 0 or git_root == "" then
    vim.notify("Not in a git repository!", vim.log.levels.ERROR)
    return
  end

  local relative_path = full_path:gsub("^" .. vim.pesc(git_root) .. "/", "")
  local git_link = "git.devpros.nl/klippa/" .. relative_path

  vim.fn.setreg("+", git_link)
  vim.notify('Copied "' .. git_link .. '" to the clipboard!')
end, {})

vim.api.nvim_set_keymap("n", "<leader>cp", ":Cppath<CR>", { noremap = true, silent = true })
