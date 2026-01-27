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

## Important

- Do NOT use `apt-get`, `apt`, or other system package managers - they require
  root which is not available
- Installed tools persist across container restarts (cached in the mounted home
  directory)
- Check available pkgx packages at https://pkgx.dev/pkgs/
