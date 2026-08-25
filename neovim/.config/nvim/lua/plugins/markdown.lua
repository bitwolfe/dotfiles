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
  -- Adjust some render-markdown defaults
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    opts = {
      heading = {
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
        position = 'inline',
        -- border = true,
        -- border_virtual = true,
      },
      code = {
        language_border = ' ',
        language_left = '',
        language_right = '',
      }
    },
    config = function (_, opts)
      require('render-markdown').setup(opts)

      -- Override inline code background color to match code blocks for text readability
      local code_block = vim.api.nvim_get_hl(0, { name = 'RenderMarkdownCode', link = false })
      vim.api.nvim_set_hl(0, 'RenderMarkdownCodeInline', { bg = code_block.bg })
    end,
  },
  -- Make the markdown linter follow some global rules
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          prepend_args = { "--config", vim.fn.stdpath("config") .. "/.markdownlint.yaml", "--" },
        },
      },
    },
  },
}
