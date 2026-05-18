output "instance_public_ips" {
  value = {
    for instance in aws_instance.ec2_instance :
    instance.tags.Name => instance.public_ip
  }
  sensitive = false
}