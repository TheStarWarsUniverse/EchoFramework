---
sidebar_position: 3
---

# Wally Packages

The Echo framework support using [wally](https://wally.run) packages.

## Installation

### 1. From GitHub
Pre-built binaries are available for Windows, macOS, and Linux from the [GitHub Releases Page for Wally](https://github.com/UpliftGames/wally/releases).

### 2. With Foreman
[Foreman](https://github.com/Roblox/foreman) is a toolchain manager developed for the Roblox community. You can use it to install Wally:
```
wally = { source = "UpliftGames/wally", version = "0.3.1" }
```

### 3. From Source
It's straightforward to compile Wally from source. Wally requires Rust 1.51.0 or newer.

Clone the repository and use:
```
cargo install --locked --path .
```

## Usuage

1. Go to [Wally.run](https://wally.run)
2. Find the package you need and copy the Metadata. Example `Cmdr = "evaera/cmdr@1.8.4"`
3. Paste it on the script called wally.toml.
4. Put it under `dependencies` or `server-dependencies`. Depends the realm of your package.
5. Run `wally install` in command bar after complete.