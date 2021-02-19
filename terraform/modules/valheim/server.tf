resource "digitalocean_droplet" "valheim" {
  image = "ubuntu-20-04-x64"
  name = "valheim"
  region = "nyc1"
  monitoring = true
  size = "s-2vcpu-4gb"
  ipv6 = true
  private_networking = true
  tags = [
    "game"
  ]
  ssh_keys = [digitalocean_ssh_key.valheim.fingerprint]

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /opt/valheim",
      "mkdir -p /etc/sysconfig",
      "sed -i 's/1/0/g' /etc/apt/apt.conf.d/20auto-upgrades"
    ]

    connection {
      type = "ssh"
      user = "root"
      host = self.ipv4_address
      private_key = file("~/.ssh/id_valheim")
    }
  }

  provisioner "file" {
    content = templatefile("${path.module}/conf/valheim-server.conf.tpl", {
      server_name = var.server_name,
      server_pass = var.server_pass,
      world_name = var.world_name
    })
    destination = "/etc/sysconfig/valheim-server"

    connection {
      type = "ssh"
      user = "root"
      host = self.ipv4_address
      private_key = file("~/.ssh/id_valheim")
    }
  }

  provisioner "file" {
    source = "${path.module}/conf/valheim-server.service"
    destination = "/etc/systemd/system/valheim-server.service"

    connection {
      type = "ssh"
      user = "root"
      host = self.ipv4_address
      private_key = file("~/.ssh/id_valheim")
    }
  }

  provisioner "remote-exec" {
    inline = [
      "apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq apt-transport-https ca-certificates curl gnupg-agent",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -",
      "echo 'deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable' > /etc/apt/sources.list.d/docker.list",
      "apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq docker-ce docker-ce-cli containerd.io",
      "systemctl daemon-reload",
      "systemctl enable --now valheim-server.service",
      "sed -i 's/0/1/g' /etc/apt/apt.conf.d/20auto-upgrades"
    ]

    connection {
      type = "ssh"
      user = "root"
      host = self.ipv4_address
      private_key = file("~/.ssh/id_valheim")
    }
  }
}
