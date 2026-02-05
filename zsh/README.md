# Zsh Configuration

This directory contains a modular zsh configuration.

## Setup

Symlink `zshrc` to your home directory:

```bash
ln -s /path/to/this/repo/zsh/zshrc ~/.zshrc
```

Or if you're already in this directory:

```bash
ln -s "$(pwd)/zshrc" ~/.zshrc
```

## Structure

- `zshrc` - Entry point, sources all other files
- `init.sh` - Main loader that sources sections in order
- `env.sh` - PATH exports and history settings
- `omz.sh` - Oh-my-zsh configuration and plugins
- `aliases.sh` - Aliases and shell functions
- `title.sh` - Terminal tab title configuration
- `tools/` - Individual tool configurations (auto-discovered)

## Adding New Tools

Create a new `.sh` file in `tools/` and it will be automatically sourced on next shell start.

## Private Configuration

Machine-specific configuration should go in `~/.zshrc_private` (created outside this repo).
