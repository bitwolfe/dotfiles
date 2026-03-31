local lspconfig = require("lspconfig")

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      format_notify = true,
      inlay_hints = {
        enable = true,
      },
      servers = {
        rubocop = {
          cmd = { "bundle", "exec", "rubocop", "--lsp" },
          root_dir = lspconfig.util.root_pattern("Gemfile", ".git", "."),
          filetypes = { "ruby" },
        },
        ruby_lsp = {
          cmd = { "bundle", "exec", "ruby-lsp" },
          filetypes = { "ruby" },
        },
        solargraph = {
          cmd = { os.getenv("HOME") .. "/.asdf/shims/solargraph", "stdio" },
          root_dir = lspconfig.util.root_pattern("Gemfile", ".git", "."),
          filetypes = { "ruby" },
          settings = {
            solargraph = {
              autoformat = true,
              completion = true,
              diagnostics = true,
              folding = true,
              references = true,
              rename = true,
              symbols = true,
            },
          },
        },
        stylelint_lsp = {
          filetypes = { "css", "scss", "less" },
          settings = {
            stylelintplus = {
              autoFixOnFormat = true,
            },
          },
        },
      },
    },
  },
}
