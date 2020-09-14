
resource "digitalocean_domain" "default" {
   name = "climatemojo.com"
   ip_address = digitalocean_droplet.app1.ipv4_address
}

resource "digitalocean_record" "www-cname" {
  domain = digitalocean_domain.default.name
  type = "CNAME"
  name = "www"
  value = "@"
}

resource "digitalocean_record" "app-cname" {
  domain = digitalocean_domain.default.name
  type = "CNAME"
  name = "app"
  value = "@"
}
