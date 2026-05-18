resource "digitalocean_droplet" "terraform-github" {
  image  = var.image
  count  = 1
  name   = "${var.label}-${var.image}-${count.index + 1}"
  region = var.do_region
  size   = var.do_instance_type
  ssh_keys = [
    var.ssh_fingerprint
  ]

  #  user_data = file("${path.root}/scripts/cloud_init.yaml") ## Uncomment to use with cloud-init.
}