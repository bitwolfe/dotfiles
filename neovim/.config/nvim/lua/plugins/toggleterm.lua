return {
  "akinsho/toggleterm.nvim",
  version = "2.13.1",
  lazy = true,
  cmd = { "ToggleTerm" },
  keys = {
    { "<c-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
  },
  opts = {
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    start_in_insert = true,
    insert_mappings = true,
    direction = "float",
    close_on_exit = true,
    float_opts = {
      border = "curved",
    },
  },
}
