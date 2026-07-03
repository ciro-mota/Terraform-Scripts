resource "google_compute_instance" "compute_instance" {
  count        = var.instance_count
  name         = "gcp-instance-${count.index + 1}"
  machine_type = var.instance_type
  zone         = var.gcp_zone

  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian.self_link
      type  = "pd-standard"
      size  = 20
    }
  }

  network_interface {
    network = "default"

    access_config {}
  }

  tags = [var.nginx_network_tag]

  metadata = {
    "enable-oslogin" = "FALSE"
    "ssh-keys"       = "${var.gcp_ssh_user}:${var.gcp_ssh_public_key}"
    # startup-script   = file("${path.root}/scripts/nginx.sh")
  }

  depends_on = []
}