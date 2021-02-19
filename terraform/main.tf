module "valheim" {
  source = "./modules/valheim"
  providers = {
    cloudflare = cloudflare
    digitalocean = digitalocean
  }

  root_domain_zone = var.root_domain_zone
  server_name = var.valheim_server_name
  server_pass = var.valheim_server_pass
  world_name = var.valheim_world_name
}
