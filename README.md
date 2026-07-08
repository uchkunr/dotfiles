# dotfiles

Configuration files for macOS and Linux (Debian-based) development environments.

## Directory Structure

```
dotfiles/
├── install.sh                  # Main installer script
├── Brewfile                    # macOS packages
├── README.md                   # Main documentation
├── .bashrc                     # Bash shell configuration
├── .config/                    # Tool configurations
│   ├── alacritty/
│   ├── bat/
│   ├── fish/
│   ├── nvim/
│   └── tmux/
└── install/                    # Installer module scripts
    ├── utils.sh                # Helper functions and sudo keep-alive
    ├── macos.sh                # macOS installer
    ├── linux.sh                # Linux installer
    ├── bun.sh                  # Universal Bun installer
    ├── nvm.sh                  # Universal NVM & Node.js installer
    ├── npm.sh                  # Universal npm packages installer
    ├── link.sh                 # Symlink creator & shell selector
    ├── packages.apt            # List of apt packages for Linux
    └── packages.flatpak        # List of flatpak apps for Linux
```

## Features

- **Interactive Shell Configuration:** Prompts the user to choose between `bash` (which copies `.bashrc`) and `zsh` (which symlinks `.zshrc`, `.zprofile`, `.zshenv`) configuration.
- **macOS & Linux support:** Detects the operating system automatically and runs the appropriate setup.
- **Sudo cache:** Prompts for sudo password once on Linux and keeps the token alive for the duration of the run.
- **Safe linking & copying:** Creates backups (with `.bak` extension) for existing files before symlinking or copying.
- **Chrome & VS Code:** Automatically downloads and installs the official `.deb` files on Linux.

## Setup

Run the following command to clone and install:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/uchkunr/dotfiles/master/install.sh)"
```

Or clone manually:

```bash
git clone https://github.com/uchkunr/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Contributing

https://youtu.be/81MdyDYqB-A?si=2kpah6W9aI841rl1&t=562

## Secrets

Keep local secrets in a non-tracked `~/.secrets` file.

## License

MIT
