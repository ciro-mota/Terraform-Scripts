output "instance_public_ips" {
  value       = module.compute_instances.instance_public_ips
  description = "IPs públicos das instâncias (se aplicável)"
}