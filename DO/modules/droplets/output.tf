output "droplet_ip_address" {
  value = {
    for droplet in digitalocean_droplet.terraform-github :
    droplet.name => droplet.ipv4_address
  }
  sensitive = false
}