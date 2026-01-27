# Container Environment (contai)

This environment runs inside a Docker container with sandboxed access. The
container provides strong isolation but has limited pre-installed tools.

## Installing Missing Tools

When a command or tool is not found, use `pkgx install` to install it. This
makes the tool available in PATH for subsequent use.

```sh
# Install a missing tool
pkgx install <tool>

# Then use it normally
<tool> [args...]
```

### Examples

```sh
# Need ripgrep?
pkgx install rg
rg "pattern" .

# Need a specific tool version?
pkgx install node@20
node --version
```

### One-off execution

For tools you only need once, you can run them directly without installing:

```sh
pkgx <tool> [args...]
```

### Fallback: nix-portable

If a tool is not available via pkgx, use `nix-portable` as a fallback. It has
access to 80,000+ packages from nixpkgs.

#### One-off execution with nix-portable

```sh
nix-portable nix run nixpkgs#<package> -- [args...]
```

#### Examples

```sh
# Run a tool once
nix-portable nix run nixpkgs#cowsay -- "Hello"

# Run a tool with a specific attribute path
nix-portable nix run nixpkgs#python311Packages.ipython
```

#### Installing for repeated use

To make a nix package available without the prefix, create a wrapper script:

```sh
# Create wrapper script in ~/.local/bin
mkdir -p ~/.local/bin
cat > ~/.local/bin/<tool> << 'EOF'
#!/bin/sh
exec nix-portable nix run nixpkgs#<package> -- "$@"
EOF
chmod +x ~/.local/bin/<tool>

# Then use normally
<tool> [args...]
```

#### Example: Installing cowsay via nix-portable

```sh
mkdir -p ~/.local/bin
cat > ~/.local/bin/cowsay << 'EOF'
#!/bin/sh
exec nix-portable nix run nixpkgs#cowsay -- "$@"
EOF
chmod +x ~/.local/bin/cowsay

# Now use it
cowsay "Hello from nix!"
```

### Important

- Do NOT use `apt-get`, `apt`, or other system package managers - they require
  root which is not available
- Always try `pkgx install` first (faster, simpler)
- Use `nix-portable` as a fallback for packages not in pkgx
- Installed tools persist across container restarts (cached in the mounted home
  directory)
- Check available pkgx packages at https://pkgx.dev/pkgs/
- Search nix packages at https://search.nixos.org/packages
