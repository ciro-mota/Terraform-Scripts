resource "aws_instance" "ec2_instance" {
  count                  = var.instance_count
  ami                    = var.ami != "" ? var.ami : data.aws_ami.debian.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name               = var.key_name

  associate_public_ip_address = var.associate_public_ip_address
  monitoring                  = var.monitoring
  disable_api_termination     = var.enable_termination_protection

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = true
    encrypted             = true
  }

  # user_data_base64 = filebase64("${path.root}/scripts/nginx.sh")

  tags = merge(
    {
      Name = "ec2-${count.index + 1}-${formatdate("YYYY-MM-DD", timestamp())}"
    },
    var.tags
  )

  lifecycle {
    ignore_changes = [tags]
  }

  depends_on = []
}