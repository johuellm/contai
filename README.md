# Contain AI! 📦🤖

`contai` is a very opinionated Docker-based sandbox for running AI CLI tools
for people paranoid enough to not wanting to give them access to their whole
system (i.e. normal people).

## Features

- **Sandboxed Environment**: Runs AI CLI tools in an isolated Docker container
  to protect your host system
- **Pre-installed AI CLI Tools**: Includes [OpenCode](https://opencode.ai/),
  [OpenAI Codex](https://developers.openai.com/codex/cli/),
  [GitHub Copilot](https://github.com/features/copilot/cli),
  [Google Gemini](https://github.com/google-gemini/gemini-cli), and
  [Claude Code](https://www.claude.com/product/claude-code) out of the box
- **User Permission Mapping**: Maintains your host UID/GID for seamless file
  access and ownership
- **Persistent Home Directory**: Stores configuration and data in
  `~/.local/share/contai/home` across container sessions
- **Current Directory Mounting**: Automatically mounts and uses your current
  working directory
- **Development Tools Included**: Comes with ripgrep, bat, git, Python,
  Node.js, and other essential tools
- **Symlink-friendly**: Can be symlinked as different tool names (e.g.,
  `opencode` symlink runs OpenCode directly)

## Build

To build the container image:

```sh
./build.sh
```

This will create a Docker image tagged as `contai:latest` with your host user's
UID/GID for proper file permissions.

## Installation

After building, you can install `contai` to your PATH:

```sh
# Create a bin directory in your home (if it doesn't exist)
mkdir -p ~/bin

# Copy the contai script
cp contai ~/bin/

# Make sure ~/bin is in your PATH (add to ~/.bashrc or ~/.zshrc if needed)
export PATH="$HOME/bin:$PATH"
```

### Optional: Create Symlinks for Direct Tool Access

You can create symlinks to run specific AI tools directly:

```sh
cd ~/bin
ln -s contai opencode
ln -s contai copilot
ln -s contai codex
ln -s contai gemini
ln -s contai claude
```

Now you can run tools directly (e.g., `opencode` instead of `contai opencode`).

## Usage

Run AI tools in the sandboxed environment:

```sh
# Run a specific tool
contai opencode

# Or use symlinks for direct access
opencode

# The container automatically mounts your current directory
cd /path/to/your/project
contai opencode
```

Your configuration and data will be persisted in `~/.local/share/contai/home`
across container sessions.

## Known Issues

* Tested almost exclusively with OpenCode for now.

* When configuring MCP servers that need OAuth, for example using
  [`mcp-remote`](https://github.com/geelen/mcp-remote), for completing the
  OAuth flow, you need to open a browser on your host machine. For now, you need
  to run the OAuth flow outside the container, as the container does not
  have access to your host's browser, and then copy the credentials manually.

  For example:

  ```sh
  cp -r ~/.mcp-auth/* ~/.local/share/contai/home/.mcp-auth/
  ```

## Roadmap

- [ ] Add installer script and/or Debian package for easier installation
  (including symlinks to the shipped tools)
- [ ] Add pre-built images (needs some thought about how to deal with user IDs)
- [ ] Add auto-image build when invoking `contai` if image is not found
- [ ] Find a way to complete OAuth flows from within the container
- [ ] Integrate with `docker-compose` for easier multi-container setups, for
  cases where other services are needed, like MCP servers
- [ ] Allow installing packages (add `sudo` with a config in `sudoers` that
  allow running `apt` without password)
- [ ] Add configuration file to be able to customize, for example:

  * Mapping of directories to mount into the container
  * Environment variables to pass to the container (including getting them
    from the current environment)
