output "linode_public_ip" {
  value = {
    for instance in linode_instance.terraform-github :
    instance.label => instance.ip_address
  }
  sensitive = false
}