terraform {
  required_version = ">1.9.0"
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "3.0.0"
    }
  }

  # backend "s3" {
  #   endpoints                   = { s3 = "https://us-east-1.linodeobjects.com" }
  #   profile                     = "linode"
  #   skip_credentials_validation = true
  #   skip_requesting_account_id  = true
  #   skip_region_validation      = true
  #   skip_s3_checksum            = true
  #   bucket                      = "your-bucket-name"
  #   key                         = "state/terraform.tfstate"
  #   region                      = "us-east-1"
  # }

}

module "linode" {
  source           = "./modules/linodes"
  LINODE_CLI_TOKEN = var.LINODE_CLI_TOKEN
  public_key_path  = var.public_key_path
}