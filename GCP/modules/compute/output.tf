output "instance_public_ips" {
  value = {
    for instance in google_compute_instance.compute_instance :
    instance.name => instance.network_interface[0].access_config[0].nat_ip
  }
  sensitive = false
}