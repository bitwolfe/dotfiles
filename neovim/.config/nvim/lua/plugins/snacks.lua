return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>ui",
      function()
        Snacks.toggle({
          name = "Inline Images",
          get = function()
            return Snacks.image.config.doc.inline
          end,
          set = function(state)
            Snacks.image.config.doc.inline = state

            local buf = vim.api.nvim_get_current_buf()
            Snacks.image.placement.clean(buf)
            pcall(vim.api.nvim_del_augroup_by_name, "snacks.image.inline." .. buf)
            pcall(vim.api.nvim_del_augroup_by_name, "snacks.image.doc." .. buf)
            vim.b[buf].snacks_image_attached = nil
            Snacks.image.doc.attach(buf)
          end,
        }):toggle()
      end,
      desc = "Toggle Inline Images",
    },
    -- Switch default to vertical mode for git log
    {
      "<leader>gl",
      function()
        Snacks.picker.git_log({
          layout = "vertical",
        })
      end,
      desc = "Snacks: Git Log",
    },
    -- Quickly switch git branches
    {
      "<M-b>",
      function()
        Snacks.picker.git_branches({
          layout = "select",
        })
      end,
      desc = "Snacks: Git Branches",
    },
    -- Used to view different keymaps and be able to search through them
    -- Configured here to switch to vertical mode by default
    {
      "<leader>fk",
      function()
        Snacks.picker.keymaps({
          layout = "vertical",
        })
      end,
      desc = "Snacks: Keymaps",
    },
    -- Switch buffers
    {
      "<leader>,",
      function()
        Snacks.picker.buffers({
          -- Start in normal mode
          on_show = function()
            vim.cmd.stopinsert()
          end,
          sort_lastused = true,
          win = {
            input = {
              keys = {
                ["d"] = "bufdelete",
              },
            },
            list = {
              keys = {
                ["d"] = "bufdelete",
              },
            },
          },
        })
      end,
      desc = "Snacks: Buffers",
    },
  },
  opts = {
    terminal = { enabled = true },
    picker = {
      -- focus = "list",
      layout = {
        cycle = true,
        preset = function()
          return vim.o.columns >= 240 and "default" or "vertical"
        end,
      },
      matcher = {
        frecency = true,
      },
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
      win = {
        keys = {
          -- Allow scrolling the preview the same way as in LazyGit
          ["J"] = { "preview_scroll_down", mode = { "i", "n" } },
          ["K"] = { "preview_scroll_up", mode = { "i", "n" } },
          ["H"] = { "preview_scroll_left", mode = { "i", "n" } },
          ["L"] = { "preview_scroll_right", mode = { "i", "n" } },
        },
      },
      formatters = {
        file = {
          truncate = "left",
          min_width = 60,
        },
      },
    },
    -- Enable image preview as a floating window
    image = {
      enabled = true,
      resolve = function(file, src)
        local vault = vim.fs.root(file, { ".obsidian", ".moxide.toml" })
        if not vault then
          return
        end

        local attachment = vim.fs.joinpath(vault, "99 - Meta", "attachments", src)
        if vim.uv.fs_stat(attachment) then
          return attachment
        end
      end,
      doc = {
        inline = false,
        float = true,
        max_width = vim.g.neovim_mode == "notes" and 5 or 60,
        max_height = vim.g.neovim_mode == "notes" and 2.5 or 30,
      },
    },
    -- This keeps the image on the top right corner, basically leaving your
    -- text area free, suggestion found in reddit by user `Redox_ahmii`
    -- https://www.reddit.com/r/neovim/comments/1irk9mg/comment/mdfvk8b/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
    -- styles = {
    --   snacks_image = {
    --     relative = "editor",
    --     col = -1,
    --   },
    -- },
  },
}
