return {
  "folke/snacks.nvim",
  opts = {
    terminal = { enabled = false },
    picker = {
      sources = {
        explorer = {
          hidden = true,
          exclude = { "node_modules" },
        },
        files = {
          hidden = true,
          exclude = { "node_modules" },
        },
        grep = {
          hidden = true,
          exclude = { "node_modules" },
        },
      },
    },
  },
}
