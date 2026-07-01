# dotfiles

Configuration files for macOS and Linux (Debian-based) development environments.

## Directory Structure

```
dotfiles/
├── install.sh                  # Main installer script
├── Brewfile                    # macOS packages
├── README.md                   # Main documentation
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
    ├── link.sh                 # Symlink creator
    ├── packages.apt            # List of apt packages for Linux
    └── packages.flatpak        # List of flatpak apps for Linux
```

## Features

- **macOS & Linux support:** Detects the operating system automatically and runs the appropriate setup.
- **Sudo cache:** Prompts for sudo password once on Linux and keeps the token alive for the duration of the run.
- **Safe linking:** Creates backups (with `.bak` extension) for existing files before symlinking.
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
