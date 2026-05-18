resource "random_password" "password" {
  length  = 16
  lower   = true
  upper   = true
  special = true
}

resource "linode_stackscript" "stack" {
  label       = "Nginx"
  description = "Install Nginx. Only in stable versions."
  is_public   = false
  script      = file("${path.root}/scripts/nginx.sh")
  images = ["linode/ubuntu24.04", "linode/ubuntu22.04",
    "linode/ubuntu20.04", "linode/debian12",
    "linode/almalinux8", "linode/almalinux9",
  "linode/rocky8", "linode/rocky9"]
}