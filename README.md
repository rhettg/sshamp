# SSH AMP VM Project

This project creates a virtual machine that launches and immediately drops SSH logins into the 'amp' CLI for VM customization.

## Overview

This project creates a customized virtual machine optimized for coding and development tasks using Amp, a powerful AI coding agent.

### Key Tools

- **Amp**: Frontier coding agent CLI for autonomous code editing, tool use, and complex task execution. Installed via `curl -fsSL https://ampcode.com/install.sh | bash`

- **Beads**: Project management and issue tracking tool. Installed via `curl -fsSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash`

- **VM Management**: Using Vagrant for local testing and Packer for building distributable images (inspired by HashiCorp tooling)

- **Server**: Primary testing on maeve server with existing Vagrant infrastructure

## Goals

Create a virtual machine environment where SSH login immediately provides access to the Amp coding agent for seamless VM customization and management. The VM includes all necessary tools preinstalled with minimal configuration required.

## Components

- **Packer Image**: Base VM image with preinstalled Amp CLI, Beads, and permissive Amp configuration
- **Vagrant Configuration**: Local development setup for testing VM launches
- **SSH Configuration**: Automatic launch of Amp CLI upon SSH login
- **Authentication**: Token-based via API key for non-interactive environments

## Project Management

This project uses beads for issue tracking and planning.

Run `bd list` to see current issues.

Run `bd ready` to see work ready to do.

Run `bd show <issue-id>` to view details.

## Usage

Once the VM is launched and SSH is configured, logging into the VM will automatically drop you into the Amp CLI environment for VM customization. Amp is pre-installed with a permissive configuration to minimize user prompts and allow autonomous operations.

### Authentication

Amp requires authentication on first use. For automated VM environments:

- Obtain your API key from [ampcode.com/settings](https://ampcode.com/settings)
- Set it in the VM environment: `export AMP_API_KEY=your-api-key-here`
- This allows Amp to run without interactive login prompts

Alternatively, run `amp login` in the VM to authenticate via web browser.

### Customization

Use Amp to customize the VM:

- Install software: `amp -x "install nodejs"`
- Configure services: `amp -x "set up nginx"`
- Edit files: Open files in your IDE or use Amp's editing tools

Amp's permissive config enables file access, command execution, and auto-approval of minor changes.

## Getting Started

1. Clone the repository

2. Run `bd init` to set up beads locally (say yes to git hooks for auto-sync)

3. Run `bd ready` to see next steps

4. Use Vagrant to launch the VM: `vagrant up`

5. SSH into the VM: `vagrant ssh`

6. Start customizing with amp

## Beads Git Hooks

Beads syncs the SQLite database to JSONL files in `.beads/`. For zero-lag sync across machines:

- Install git hooks: Run `bd init` and approve hooks, or manually:
  ```
  ln -s ../../.beads/git-hooks/pre-commit .git/hooks/pre-commit
  ln -s ../../.beads/git-hooks/post-merge .git/hooks/post-merge
  chmod +x .git/hooks/pre-commit .git/hooks/post-merge
  ```

This ensures issues sync before commits and after merges/pulls.
