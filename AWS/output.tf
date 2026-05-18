output "instance_public_ips" {
  value       = module.ec2_instances.instance_public_ips
  description = "IPs públicos das instâncias (se aplicável)"
}