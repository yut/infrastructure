
resource "digitalocean_droplet" "app1" {
  image = "ubuntu-20-04-x64"
  name = "app1"
  monitoring = true
  region = "sfo3"
  size = "s-1vcpu-1gb"
  private_networking = false
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt-get update",
      "sudo apt-get -y install nginx"
    ]
  }
}

resource "digitalocean_firewall" "web" {
  name = "only-22-80-and-443"

  droplet_ids = [digitalocean_droplet.app1.id]

  inbound_rule {
    protocol           = "tcp"
    port_range         = "22"
    source_addresses   = ["192.168.1.0/24", "2002:1:2::/48"]
  }

  inbound_rule {
    protocol           = "tcp"
    port_range         = "80"
    source_addresses   = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol           = "tcp"
    port_range         = "443"
    source_addresses   = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol                = "tcp"
    port_range              = "53"
    destination_addresses   = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol                = "udp"
    port_range              = "53"
    destination_addresses   = ["0.0.0.0/0", "::/0"]
  }
}
