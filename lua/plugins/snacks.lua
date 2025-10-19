return {
  "folke/snacks.nvim",
  opts = {
    scroll = {
      enabled = false, -- Disable scrolling animations
    },
    picker = {
      actions = {
        sidekick_send = function(...)
          return require("sidekick.cli.snacks").send(...)
        end,
      },
      win = {
        input = {
          keys = {
            ["<a-a>"] = {
              "sidekick_send",
              mode = { "n", "i" },
            },
          },
        },
      },
    },
  },
}
