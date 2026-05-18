variable "LINODE_CLI_TOKEN" {
  sensitive = true
}

variable "public_key_path" {
  sensitive = true
}

variable "node_count" {
  description = "Defines the number of instances that will be provisioned."
  default     = 1
}

variable "label" {
  type        = string
  description = "The name you want for your Linode instance."
  default     = "Terra_Linode"
}
variable "image" {
  type        = string
  description = <<EOT
        Linode Image type to use. Send to list all available images:
        curl --request GET \
        --url 'https://api.linode.com/v4/images?page=1&page_size=100' \
        --header 'accept: application/json' | jq '.data[].id'
  EOT
  default     = "linode/debian12"
}

variable "linode_region" {
  type        = string
  description = <<EOT
        Linode available regions to use. Send to list all available regions:
        curl --request GET \
        --url https://api.linode.com/v4/regions \
        --header 'accept: application/json' | jq '.data[].id'
        EOT
  default     = "us-east"
}
variable "linode_instance_type" {
  type        = string
  description = <<EOT
        Linode machine types to use. Send to list all available instance types:
        curl --request GET \
        --url https://api.linode.com/v4/linode/types \
        --header 'accept: application/json' | jq '.data[].id'
        EOT
  default     = "g6-nanode-1"
}