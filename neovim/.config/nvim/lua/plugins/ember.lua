return {
  {
    "NullVoxPopuli/ember.nvim",
    enabled = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("ember.nvim").config()
    end,
  },
}
