return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true, -- This is what you want: If true, hidden files are shown
          hide_dotfiles = false, -- This is what you want: If false, hidden files are shown
          hide_gitignored = false, -- This is what you want: If false, gitignored files are shown
          hide_by_name = {
            -- You can add specific files/folders to hide here
            -- ".DS_Store",
            -- "node_modules"
          },
          hide_by_pattern = {
            -- You can add patterns to hide here
            -- "*.meta",
            -- "*/src/*/tsconfig.json",
          },
          always_show = { -- remains visible even if other settings would normally hide it
            -- ".gitignore",
            -- "thumbs.db"
          },
          never_show = { -- remains hidden even if visible is toggled to true
            -- ".DS_Store",
            -- "thumbs.db"
          },
          never_show_by_pattern = { -- uses glob style patterns
            -- ".null-ls_*",
          },
        },
      },
    },
  },
}