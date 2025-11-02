packer {
  required_plugins {
    virtualbox = {
      version = "~> 1"
      source  = "github.com/hashicorp/virtualbox"
    }
  }
}

source "virtualbox-iso" "ubuntu" {
  guest_os_type = "Ubuntu_64"
  iso_url       = "https://releases.ubuntu.com/22.04/ubuntu-22.04.5-live-server-amd64.iso"
  iso_checksum  = "sha256:9bc6028870aef3f74f4e16b900008179e78b130e6b0a6016a38e1025832f3022b6"

  ssh_username = "vagrant"
  ssh_password = "vagrant"
  ssh_timeout  = "20m"

  shutdown_command = "echo 'vagrant' | sudo -S shutdown -P now"

  vboxmanage = [
    ["modifyvm", "{{.Name}}", "--memory", "2048"],
    ["modifyvm", "{{.Name}}", "--cpus", "2"],
  ]

  boot_command = [
    "<enter><enter><f6><esc><wait>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "/install/vmlinuz ",
    "initrd=/install/initrd.gz ",
    "auto=true ",
    "url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
    "<enter>"
  ]

  http_directory = "http"
}

build {
  sources = ["source.virtualbox-iso.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get upgrade -y",
      "sudo apt-get install -y curl git",
      "curl -fsSL https://ampcode.com/install.sh | bash",
      "curl -fsSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash"
    ]
  }

  provisioner "file" {
    source      = "amp-config.json"
    destination = "/tmp/amp-config.json"
  }

  provisioner "shell" {
    inline = [
      "sudo mkdir -p /home/vagrant/.amp",
      "sudo mv /tmp/amp-config.json /home/vagrant/.amp/config.json",
      "sudo chown -R vagrant:vagrant /home/vagrant/.amp"
    ]
  }

  post-processor "vagrant" {
    output = "sshamp.box"
  }
}
