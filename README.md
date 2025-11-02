# SSH AMP VM Project

This project creates a virtual machine that launches and immediately drops SSH logins into the 'amp' CLI for VM customization.

## Overview

- **amp**: A coding agent CLI installed via `curl -fsSL https://ampcode.com/install.sh | bash`

- **beads**: Project management tool using issue tracking, installed via `curl -fsSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash`

- **VM Management**: Using Vagrant for local testing, Packer for building images (inspired by HashiCorp products)

- **Server**: maeve, with existing Vagrant setup for testing

## Goals

Upon SSH login to the VM, the user is dropped directly into the 'amp' environment for VM customization.

## Components

- Packer image with preinstalled amp and beads

- Vagrant configuration for launching the VM

- SSH setup to launch amp on login

- Authentication via token (to be investigated)

## Project Management

This project uses beads for issue tracking and planning.

Run `bd list` to see current issues.

Run `bd ready` to see work ready to do.

Run `bd show <issue-id>` to view details.

## Getting Started

1. Clone the repository

2. Run `bd init` to set up beads locally

3. Run `bd ready` to see next steps

4. Use Vagrant to launch the VM: `vagrant up`

5. SSH into the VM: `vagrant ssh`

6. Start customizing with amp
