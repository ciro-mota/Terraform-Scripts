resource "google_compute_firewall" "nginx_http_https" {
  name    = "allow-nginx-http-https"
  network = "default"

  description = "Permite tráfego HTTP e HTTPS para instâncias com tag nginx"

  direction     = "INGRESS"
  source_ranges = var.nginx_allowed_source_ranges
  target_tags   = [var.nginx_network_tag]

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
}