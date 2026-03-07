# `.dotfiles`

This is where I'm gonna keep my machine-to-machine config files.

## Installation

Clone this repository with submodules:

```bash
git clone --recurse-submodules git@github.com:<username>/dotfiles.git
```

## YubiKey SSH Bootstrap

Reference guide: https://github.com/drduh/YubiKey-Guide

To quickly set up SSH via YubiKey-backed `gpg-agent` on a new machine, run:

```bash
./scripts/setup-yubikey-ssh.sh
```

<!-- Don't forget to import your key(s), ya goof. -->

Prerequisites:

```bash
gpg --version
gpgconf --version
ssh -V
```

If `gpg`/`gpgconf` is missing on macOS:

```bash
brew install gnupg pinentry-mac
```

This script configures `~/.gnupg/gpg-agent.conf` with `enable-ssh-support`, adds an SSH include (`~/.ssh/config.d/10-gpg-agent.conf`) with `IdentityAgent`, and ensures `~/.ssh/config` includes `~/.ssh/config.d/*.conf`.

After running it:

```bash
ssh-add -L
ssh -T git@github.com
```

If no key is listed yet, run:

```bash
gpg --card-status
```

If SSH says `agent refused operation` and no pinentry appears, reload your shell so `GPG_TTY` and `updatestartuptty` are refreshed, then run non-destructive checks first:

```bash
echo "$GPG_TTY"
gpgconf --list-dirs agent-socket agent-ssh-socket
ssh -G github.com | grep -i identityagent
```
