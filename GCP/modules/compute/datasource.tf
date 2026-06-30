locals {
  gcp_image_value   = trimspace(var.gcp_image)
  gcp_image_parts   = local.gcp_image_value != "" ? split("/", local.gcp_image_value) : []
  gcp_image_project = local.gcp_image_value == "" ? "debian-cloud" : (length(local.gcp_image_parts) > 1 ? local.gcp_image_parts[0] : "debian-cloud")
  gcp_image_family  = local.gcp_image_value == "" ? "debian-13" : (length(local.gcp_image_parts) > 1 ? local.gcp_image_parts[1] : local.gcp_image_value)
}

data "google_compute_image" "debian" {
  project = local.gcp_image_project
  family  = local.gcp_image_family
}