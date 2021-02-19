resource "digitalocean_firewall" "ssh" {
  name = "ssh-inbound"

  droplet_ids = [digitalocean_droplet.valheim.id]

  inbound_rule {
    protocol = "tcp"
    port_range = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_firewall" "game" {
  name = "game-inbound"

  droplet_ids = [digitalocean_droplet.valheim.id]

  inbound_rule {
    protocol = "udp"
    port_range = "2456-2458"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_firewall" "outbound-all" {
  name = "allow-all-outbound"

  droplet_ids = [digitalocean_droplet.valheim.id]

  outbound_rule {
    protocol = "tcp"
    port_range = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol = "udp"
    port_range = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol = "icmp"
    port_range = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
