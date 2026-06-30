variable "gcp_region" {
  type        = string
  default     = "us-east1"
  description = "Região GCP onde os recursos serão criados"
}

variable "gcp_project" {
  type        = string
  description = "ID do projeto GCP onde os recursos serão criados"
}

variable "gcp_zone" {
  type        = string
  default     = "us-east1-b"
  description = "Zona GCP onde os recursos serão criados"
}

variable "instance_count" {
  type        = number
  default     = 1
  description = "Número de instâncias a serem criadas"

  validation {
    condition     = var.instance_count == 1
    error_message = "No modo always free, apenas 1 instância pode ser criada."
  }
}

variable "instance_type" {
  type        = string
  default     = "e2-micro"
  description = "Tipo de máquina GCP"

  validation {
    condition     = contains(["e2-micro", "f1-micro"], var.instance_type)
    error_message = "No modo always free, use apenas e2-micro ou f1-micro."
  }
}

variable "gcp_image" {
  type        = string
  default     = "debian-cloud/debian-13"
  description = "Imagem ou família Debian da GCP (padrão: Debian 13)"
}

variable "gcp_ssh_user" {
  type        = string
  description = "Nome do usuário SSH a ser criado na instância"

  validation {
    condition     = length(trimspace(var.gcp_ssh_user)) > 0
    error_message = "Informe um usuário SSH válido."
  }
}

variable "gcp_ssh_public_key" {
  type        = string
  description = "Chave pública SSH previamente gerada pelo usuário"

  validation {
    condition     = length(trimspace(var.gcp_ssh_public_key)) > 0
    error_message = "Informe uma chave pública SSH válida."
  }
}
