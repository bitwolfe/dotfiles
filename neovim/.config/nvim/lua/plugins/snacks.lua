return {
  "folke/snacks.nvim",
  keys = {
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
      focus = "list",
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
  },
}
