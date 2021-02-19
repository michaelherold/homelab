resource "cloudflare_record" "valheim" {
  zone_id = var.root_domain_zone

  name = "valheim"
  type = "A"
  ttl = "1"
  proxied = false

  value = digitalocean_droplet.valheim.ipv4_address
}
