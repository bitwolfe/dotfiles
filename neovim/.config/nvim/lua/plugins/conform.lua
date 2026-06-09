return {
  {
    "stevearc/conform.nvim",
    opts = function()
      local config = { "prettier", stop_after_first = true }

      local opts = {
        default_format_opts = {
          timeout_ms = 3000,
        },
        formatters_by_ft = {
          -- Use a sub-list to run only the first available formatter
          javascript = config,
          typescript = config,
          ["javascript.glimmer"] = config,
          ["typescript.glimmer"] = config,
        },
        formatters = {
          -- We don't want to enable prettierd
          -- because it requires global installation, and then
          -- we can't even have projects without prettier
          -- NOTE: make sure prettier (and prettierd) are not installed globally
          prettier = {
            require_cwd = true,
          },
        },
      }
      return opts
    end
  },
}
