# Neovim Configuration

Neovim setup built on top of [LazyVim](https://github.com/LazyVim/LazyVim).

## Theme

- **Colorscheme:** [Catppuccin Mocha](https://github.com/catppuccin/nvim)
- **Transparency:** Enabled (`transparent_background = true`)

## File Structure

```
nvim/
├── init.lua                    # Neovim entrypoint
├── lazyvim.json                # LazyVim configuration file
├── stylua.toml                 # Lua code formatter settings
└── lua/
    ├── config/
    │   ├── autocmds.lua        # Autocommands
    │   ├── keymaps.lua         # Custom keymaps
    │   ├── lazy.lua            # Lazy.nvim setup
    │   └── options.lua         # Editor options
    └── plugins/
        ├── example.lua         # Plugin configuration example
        ├── neo-tree.lua        # File explorer configuration
        ├── theme.lua           # Theme configuration
        └── snacks-animated-scrolling-off.lua # Scrolling settings
```

## Setup

The files are linked to `~/.config/nvim` when running the main installer. When you launch `nvim` for the first time, LazyVim will install the plugins.

```bash
nvim
```
