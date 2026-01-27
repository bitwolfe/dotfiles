return {
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    keys = {
      {
        "<leader>cpt",
        function()
          require("package-info").toggle()
        end,
        desc = "Toggle package info",
      },
      {
        "<leader>cpi",
        function()
          require("package-info").install()
        end,
        desc = "Install package",
      },
      {
        "<leader>cpu",
        function()
          require("package-info").update()
        end,
        desc = "Update package",
      },
      {
        "<leader>cpd",
        function()
          require("package-info").delete()
        end,
        desc = "Delete package",
      },
      {
        "<leader>cpv",
        function()
          require("package-info").change_version()
        end,
        desc = "Change package version",
      },
    },
    config = function()
      local colors = require("catppuccin.palettes").get_palette("mocha")

      require("package-info").setup({
        package_manager = "npm",
        highlights = {
          up_to_date = { fg = colors.green },
          outdated = { fg = colors.yellow },
          unlisted = { fg = colors.overlay0 },
        },
        autostart = true,
        hide_up_to_date = true,
      })
    end,
  },
}
