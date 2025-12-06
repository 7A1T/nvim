return {
  {
    "letieu/graphql.nvim",
    keys = {
      {
        "<leader>Gg",
        function()
          require("graphql").open()
        end,
        desc = "graphql - Open",
      },
      {
        "<leader>Gq",
        function()
          require("graphql").close()
        end,
      },
      {
        "<leader>Gr",
        function()
          require("graphql").run()
        end,
      },
    },
  },
}
