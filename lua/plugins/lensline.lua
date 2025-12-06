return {
  "oribarilan/lensline.nvim",
  event = "LspAttach",
  config = function()
    require("lensline").setup({
      -- Profile configuration (first profile used as default)
      -- Note: omitting 'providers' or 'style' in a profile inherits defaults
      -- You can also override just specific properties (e.g., style = { placement = "inline" })
      profiles = {
        {
          name = "default",
          providers = { -- Array format: order determines display sequence
            {
              name = "usages",
              enabled = true, -- enable usages provider by default (replaces references)
              include = { "refs", "impls", "defs" }, -- refs-only setup to match references provider behavior
              breakdown = true, -- false = aggregate count, true = breakdown by type
              show_zero = true, -- show zero counts when LSP supports the capability
              labels = {
                refs = "refs",
                impls = "impls",
                defs = "defs",
                usages = "usages",
              },
              icon_for_single = "󰌹 ", -- icon when only one attribute or aggregate display
              inner_separator = ", ", -- separator between breakdown items
            },
            {
              name = "last_author",
              enabled = true, -- enabled by default with caching optimization
              cache_max_files = 50, -- maximum number of files to cache blame data for (default: 50)
            },
            {
              name = "complexity",
              enabled = true,
              min_level = "L", -- only show L and XL complexity (default)
            },
            {
              name = "function_length",
              enabled = true,
              event = { "BufWritePost", "TextChanged" },
              handler = function(bufnr, func_info, provider_config, callback)
                local utils = require("lensline.utils")
                local function_lines = utils.get_function_lines(bufnr, func_info)
                local func_line_count = math.max(0, #function_lines - 1) -- Subtract 1 for signature
                local total_lines = vim.api.nvim_buf_line_count(bufnr)

                -- Show line count for all functions
                callback({
                  line = func_info.line,
                  text = string.format("(%d/%d lines)", func_line_count, total_lines),
                })
              end,
            },
          },
        },
      },
    })
  end,
}
