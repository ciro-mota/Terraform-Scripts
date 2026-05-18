<h2>AWS</h2>

<p align="center">
    <img alt="AWS" src="https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white" />
    <img alt="Terraform" src="https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white" />
    <img alt="OpenTofu" src="https://img.shields.io/badge/OpenTofu-FFDA18?logo=opentofu&logoColor=000&style=for-the-badge" />
    <img alt="Ansible" src="https://img.shields.io/badge/Ansible-000000?style=for-the-badge&logo=ansible&logoColor=white" />
    <img alt="AlmaLinux" src="https://img.shields.io/badge/AlmaLinux-000?logo=almalinux&logoColor=fff&style=for-the-badge" />
    <img alt="Amazon Linux" src="https://img.shields.io/badge/Amazon_Linux-FF9900?logo=&style=for-the-badge" />
    <img alt="Ubuntu" src="https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white" />
    <img alt="Shell Script" src="https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white" />
</p>

Módulo Terraform para provisionar instâncias EC2 na AWS com segurança e boas práticas.

## 📋 Pré-requisitos

1. **AWS Account**: Conta AWS ativa com permissões necessárias.
2. **Terraform**: v1.9.0 ou superior.
3. **AWS_SECRET_ACCESS_KEY**: Configurado com credenciais válidas.
4. **Recursos Existentes**:
   - VPC já criada.
   - Subnet na VPC.
   - Security Group configurado.
   - Key Pair para acesso SSH.

## 🚀 Início Rápido

### 1. Configurar Credenciais AWS

**Opção A: Variáveis de Ambiente**
```bash
export AWS_ACCESS_KEY_ID="sua-chave"
export AWS_SECRET_ACCESS_KEY="sua-secret"
export AWS_REGION="us-east-2"
```

**Opção B: Arquivo ~/.aws/credentials**
```
[default]
aws_access_key_id = sua-chave
aws_secret_access_key = sua-secret
region = us-east-2
```

**Opção C: IAM Role (recomendado para produção)**
Se executado em EC2 ou ECS, use uma IAM role associada.

### 2. Preparar Arquivo de Configuração

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edite `terraform.tfvars` e preencha:
- `subnet_id`: ID da sua subnet
- `vpc_security_group_ids`: IDs do seu security group
- `key_name`: Nome da sua key pair
- Outras configurações conforme necessário

### 3. Inicializar Terraform

```bash
terraform init
```

### 4. Validar Configuração

```bash
terraform validate
terraform plan
```

### 5. Aplicar Configuração

```bash
terraform apply
```

## 📁 Estrutura do Projeto

```
.
├── main.tf                    # Configuração principal e provider
├── variables.tf               # Variáveis da raiz
├── output.tf                  # Outputs
├── terraform.tfvars.example   # Exemplo de valores das variáveis
├── README.md                  # Este arquivo
└── modules/
    └── ec2/                   # Módulo EC2
        ├── instance.tf        # Recurso aws_instance
        ├── variables.tf       # Variáveis do módulo
        ├── output.tf          # Outputs do módulo
        ├── provider.tf        # Configuração do provider
        └── resources.tf       # Outros recursos (comentários)
```

## 🔧 Variáveis Principais

### Requeridas
- `subnet_id`: ID da subnet onde a instância será criada
- `vpc_security_group_ids`: Lista de IDs dos security groups

### Opcionais com Defaults
- `instance_count`: Número de instâncias (padrão: 1)
- `instance_type`: Tipo de instância (padrão: t3.micro)
- `ami`: ID da AMI (padrão: Ubuntu 22.04 LTS)
- `key_name`: Nome da key pair (padrão: "aws")
- `associate_public_ip_address`: Associar IP público (padrão: true)
- `monitoring`: CloudWatch detailed monitoring (padrão: false)
- `root_volume_size`: Tamanho do volume em GB (padrão: 20)
- `root_volume_type`: Tipo de volume (padrão: gp3)
- `enable_termination_protection`: Proteção contra deleção (padrão: false)

## 📊 Outputs

Após aplicar, você terá acesso a:
- `ec2_instances`: Informações detalhadas de cada instância
- `instance_ids`: IDs das instâncias
- `instance_public_ips`: IPs públicos
- `instance_private_ips`: IPs privados
- `connection_info`: Informações de conexão SSH

## 🔐 Segurança

### ✅ Boas Práticas Implementadas

1. **Credenciais**:
   - Não armazena credenciais no código.
   - Suporta variáveis de ambiente, arquivo de credenciais ou IAM role.
   - Variáveis sensíveis marcadas como sensíveis.

2. **Armazenamento**:
   - Volume root criptografado por padrão.
   - Suporta diferentes tipos de volume (gp3, io1, etc).

3. **Proteção**:
   - Opção de termination protection.
   - Validação de input com terraform.
   - Lifecycle rules para evitar perda acidental.

4. **Monitoramento**:
   - CloudWatch detailed monitoring disponível.
   - Tags padrão em todos os recursos.

### ⚠️ Recomendações para Produção

1. **State Backend**: Configure remote state (S3 + DynamoDB).
   ```hcl
   terraform {
     backend "s3" {
       bucket         = "seu-bucket-state"
       key            = "prod/terraform.tfstate"
       region         = "us-east-2"
       dynamodb_table = "terraform-locks"
       encrypt        = true
     }
   }
   ```

2. **Variables Secrets**: Use `sensitive = true` para dados sensíveis.

3. **Security Groups**: Restrinja inbound/outbound conforme necessário.

4. **Backup**: Habilite EBS snapshots.

5. **Monitoring**: Ative CloudWatch monitoring detalhado.

## 🔄 Exemplos de Uso

### Criar 2 instâncias

```hcl
instance_count   = 2
```

### Usar instância maior

```hcl
instance_type = "t3.small"
root_volume_size = 50
```

### Produção com proteção

```hcl
enable_termination_protection = true
monitoring = true
resource_tags = {
  Environment = "production"
  Critical    = "true"
}
```

## 🧹 Limpeza

Para destruir todos os recursos criados:

```bash
terraform destroy
```

**Atenção**: Instâncias com `enable_termination_protection = true` não serão destruídas automaticamente.

## 📝 Logs e Debugging

### Aumentar verbosidade

```bash
export TF_LOG=DEBUG
terraform plan
unset TF_LOG
```

### Ver plan em JSON

```bash
terraform plan -json | jq .
```

## 🆘 Troubleshooting

### Erro: "InvalidKeyPair.NotFound"
- Verifique se a key pair existe na AWS.
- Confirme a região correta.

### Erro: "InvalidSubnetID.NotFound"
- Verifique se a subnet existe.
- Confirme que está na mesma região.

### Erro: "InvalidGroupId.NotFound"
- Verifique se o security group existe.
- Confirme que está na mesma VPC da subnet.

### Erro: "UnauthorizedOperation"
- Verifique credenciais AWS.
- Confirme permissões IAM necessárias.
