return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 997,
  opts = {
    flavour = "mocha",
    transparent_background = true,
    auto_integrations = true,
  },
  config = function()
    vim.cmd.colorscheme "catppuccin"
  end
}
