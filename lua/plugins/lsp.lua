return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      gopls = {
        settings = {
          gopls = {
            analyses = {
              -- Disable specific staticcheck warnings
              -- Example: ST1003 checks for ID/Id naming conventions
              ST1003 = false,
              ST1000 = false,
            },
          },
        },
      },
    },
  },
}
