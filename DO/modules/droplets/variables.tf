variable "do_token" {
  sensitive = true
}

variable "ssh_fingerprint" {
  sensitive = true
}

variable "label" {
  type        = string
  description = "The name you want for your DigitalOcean instance."
  default     = "Terra-DO"
}

variable "image" {
  type        = string
  description = <<EOT
        DigitalOcean Images available. Send to list all available Images: curl -X GET \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer <your-digital-ocean-token>" \
        "https://api.digitalocean.com/v2/images?page=1&per_page=100&type=distribution" | jq '.images[].slug'
        EOT
  default     = "debian-12-x64"
}

variable "do_region" {
  type        = string
  description = <<EOT
        DigitalOcean available regions. Send to list all available Regions: curl -X GET \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer <your-digital-ocean-token>" \
        "https://api.digitalocean.com/v2/regions" | jq '.regions[].slug'
        EOT
  default     = "nyc3"
}

variable "do_instance_type" {
  type        = string
  description = <<EOT
        DigitalOcean Droplets types to use. Send to list all available Droplets types: curl -X GET \
        -H "Content-Type: application/json" 
        -H "Authorization: Bearer <your-digital-ocean-token>" \
        "https://api.digitalocean.com/v2/sizes" | jq '.sizes[].slug'
        EOT
  default     = "s-1vcpu-2gb"
}