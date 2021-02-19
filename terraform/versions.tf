terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 2.18"
    }

    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.5"
    }
  }

  required_version = "~> 0.14"
}
