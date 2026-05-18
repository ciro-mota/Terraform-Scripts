variable "instance_count" {
  type        = number
  default     = 1
  description = "Número de instâncias EC2 a serem criadas"

  validation {
    condition     = var.instance_count > 0 && var.instance_count <= 10
    error_message = "O número de instâncias deve estar entre 1 e 10."
  }
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Tipo de instância EC2"
}

variable "ami" {
  type        = string
  default     = "" // ami-05ddd376a2aa89ddf AlmaLinux 10
  description = "ID da AMI (opcional). Se vazio, o módulo usará lookup dinâmico do Debian."
}

variable "subnet_id" {
  type        = string
  description = "ID da subnet VPC onde a instância será criada"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Lista de IDs dos security groups já configurados para a instância"
}

variable "key_name" {
  type        = string
  default     = "aws"
  description = "Nome da key pair já criada na AWS"
}

variable "associate_public_ip_address" {
  type        = bool
  default     = true
  description = "Associar um IP público à instância"
}

variable "monitoring" {
  type        = bool
  default     = false
  description = "Habilitar CloudWatch detailed monitoring"
}

variable "root_volume_size" {
  type        = number
  default     = 32
  description = "Tamanho do volume root em GB"
}

variable "root_volume_type" {
  type        = string
  default     = "gp3"
  description = "Tipo de volume root (gp3, gp2, io1, etc)"
}

variable "enable_termination_protection" {
  type        = bool
  default     = false
  description = "Proteger a instância contra terminação acidental"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags adicionais para aplicar aos recursos"
}