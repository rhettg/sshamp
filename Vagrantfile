# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"  # Ubuntu 22.04 LTS

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
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
    su - vagrant -c "cd /home/vagrant && ~/go/bin/bd init --yes"

    # Set up git hooks for beads sync
    su - vagrant -c "cd /home/vagrant && ln -sf ../../.beads/git-hooks/pre-commit .git/hooks/pre-commit"
    su - vagrant -c "cd /home/vagrant && ln -sf ../../.beads/git-hooks/post-merge .git/hooks/post-merge"
    su - vagrant -c "cd /home/vagrant && chmod +x .git/hooks/pre-commit .git/hooks/post-merge"
  SHELL
end
