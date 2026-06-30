terraform {
  required_version = ">= 1.11.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.38.0"
    }
  }
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
  zone    = var.gcp_zone
}

module "compute_instances" {
  source             = "./modules/compute"
  gcp_region         = var.gcp_region
  gcp_zone           = var.gcp_zone
  instance_count     = var.instance_count
  instance_type      = var.instance_type
  gcp_image          = var.gcp_image
  gcp_ssh_user       = var.gcp_ssh_user
  gcp_ssh_public_key = var.gcp_ssh_public_key
}
