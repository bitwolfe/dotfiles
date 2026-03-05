return {
  {
    "mikavilpas/yazi.nvim",
    version = "*", -- use latest stable version
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      lazy = true,
    },
    keys = {
      {
        "<leader>gy",
        mode = { "n", "v" },
        "<cmd>Yazi cwd<cr>",
        desc = "Open Yazi at cwd",
      },
      {
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Toggle Yazi",
      },
    },
  },
}
