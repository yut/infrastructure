
# Use the DigitalOcean provider
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "1.22.2"
    }
  }
}

# Define variables to use in the rest of the configuration. Pass values into Terraform when you run it.
variable "do_token" {}
variable "pvt_key" {}
variable "ocean_ssh_key" {}

# Set the provider token to our command line token.
provider "digitalocean" {
  token = var.do_token
}

# Use DO ssh key for these resources. The key is defined in DigitalOcean.
data "digitalocean_ssh_key" "terraform" {
  name = var.ocean_ssh_key
}
