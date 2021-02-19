resource "digitalocean_ssh_key" "valheim" {
  name = "valheim"
  public_key = file("~/.ssh/id_valheim.pub")
}
