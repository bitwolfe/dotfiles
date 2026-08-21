-- Markdown configuration to use markdown-oxide for my Obsidian vault
-- and marksman for everything else (default from lang.markdown extra)

local function oxide_root(bufnr, on_dir)
  local root = vim.fs.root(bufnr, { ".obsidian", ".moxide.toml" })
  if root then
    on_dir(root)
  end
end

local function marksman_root(bufnr, on_dir)
  if vim.fs.root(bufnr, { ".obsidian", ".moxide.toml" }) then
    return
  end

  on_dir(vim.fs.root(bufnr, { ".marksman.toml", ".git" }) or vim.fn.getcwd())
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        markdown_oxide = {
          root_dir = oxide_root,
          capabilities = {
            workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = true,
              },
            },
          },
        },
        marksman = {
          root_dir = marksman_root,
        },
      },
    },
  },
}
