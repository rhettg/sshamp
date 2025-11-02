# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2204"  # Ubuntu 22.04 LTS

  config.vm.provider "libvirt" do |libvirt|
    libvirt.memory = 2048
    libvirt.cpus = 2
  end

  # Provisioning script to install amp, beads, and configure
  config.vm.provision "shell", inline: <<-SHELL
    # Update system
    apt-get update
    apt-get upgrade -y

    # Install required packages
    apt-get install -y curl git

    # Install Amp CLI
    curl -fsSL https://ampcode.com/install.sh | bash

    # Install Beads
    curl -fsSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash

    # Create permissive amp config
    mkdir -p /home/vagrant/.amp
    cat > /home/vagrant/.amp/config.json << 'EOF'
{
  "permissions": {
    "file_access": true,
    "network_access": true,
    "command_execution": true,
    "auto_approve_minor_changes": true
  },
  "behavior": {
    "prompt_for_major_changes": false,
    "allow_file_modifications": true,
    "allow_code_execution": true
  }
}
EOF

    # Set ownership
    chown -R vagrant:vagrant /home/vagrant/.amp
    chown -R vagrant:vagrant /home/vagrant/.beads 2>/dev/null || true

    # Initialize beads (run as vagrant user)
    su - vagrant -c "cd /vagrant && ~/go/bin/bd init --yes"

    # Set up git hooks for beads sync
    su - vagrant -c "cd /vagrant && ln -sf .beads/git-hooks/pre-commit .git/hooks/pre-commit"
    su - vagrant -c "cd /vagrant && ln -sf .beads/git-hooks/post-merge .git/hooks/post-merge"
    su - vagrant -c "cd /vagrant && chmod +x .git/hooks/pre-commit .git/hooks/post-merge"

    # Configure SSH login to drop into amp
    cat >> /home/vagrant/.bashrc << 'EOF'

# If this is an SSH login, drop into amp
if [[ -n $SSH_TTY ]]; then
  export PATH="$PATH:/home/vagrant/.local/bin"
  exec amp --dangerously-allow-all
fi
EOF

    # Create AGENTS.md for Amp guidance
    cat > /vagrant/AGENTS.md << 'EOF'
# AGENTS.md for SSH AMP VM

This is a virtual machine environment optimized for coding and development tasks using the Amp AI coding agent.

## Environment Access

You have full access to the entire VM:
- **File System**: Complete read/write access to all directories
- **Command Execution**: Ability to run any shell commands without prompts (--dangerously-allow-all)
- **Network Access**: Full internet access for installations and downloads
- **Package Management**: Install software, update packages, configure services

## Intended Use

This VM is designed for:
- Installing and configuring development tools
- Setting up programming environments
- Testing applications and deployments
- Automating VM customization tasks

## Permissions

Amp runs with permissive settings allowing autonomous operation. All tool uses are automatically approved.

## Available Tools

- Package managers: apt, pip, npm, etc.
- System tools: systemctl, user management
- Development tools: git, compilers, editors
- Network tools: curl, wget, ssh

Use your full capabilities to help customize and manage this VM environment.
EOF
  SHELL
end
