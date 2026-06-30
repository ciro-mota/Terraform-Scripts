<h2>GCP Always Free</h2>

<p align="center">
   <img alt="GCP" src="https://img.shields.io/badge/GCP-%234285F4.svg?style=for-the-badge&logo=googlecloud&logoColor=white" />
    <img alt="Terraform" src="https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white" />
    <img alt="OpenTofu" src="https://img.shields.io/badge/OpenTofu-FFDA18?logo=opentofu&logoColor=000&style=for-the-badge" />
    <img alt="Ansible" src="https://img.shields.io/badge/Ansible-000000?style=for-the-badge&logo=ansible&logoColor=white" />
    <img alt="AlmaLinux" src="https://img.shields.io/badge/AlmaLinux-000?logo=almalinux&logoColor=fff&style=for-the-badge" />
    <img alt="Amazon Linux" src="https://img.shields.io/badge/Amazon_Linux-FF9900?logo=&style=for-the-badge" />
    <img alt="Ubuntu" src="https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white" />
    <img alt="Shell Script" src="https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white" />
</p>

Módulo Terraform para provisionar uma VM GCP compatível com o Always Free.

## 📋 Pré-requisitos

1. **Google Cloud Account**: Projeto GCP ativo com faturamento habilitado.
2. **Terraform** v1.15.0 ou superior; **OpenTofu** v1.11.0 ou superior.
3. **Google Cloud CLI ou credenciais**: Autenticação configurada para o projeto.
4. **Chave SSH pública**: tenha um par de chaves já gerado localmente.

## 🚀 Início Rápido

### 1. Configurar Credenciais GCP

Crie um projeto em `https://console.cloud.google.com` e guarde a ID gerada.

Execute os comandos:

```bash
gcloud auth login
gcloud auth application-default login
gcloud config set project <id-do-projeto>
gcloud auth application-default set-quota-project <id-do-projeto>
```

Ative as APIs necessárias:

```bash
gcloud services enable serviceusage.googleapis.com
gcloud services enable compute.googleapis.com
```

### 2. Exportar variáveis no `.zshenv`

Adicione as variáveis abaixo ao seu `~/.zshenv` para o Terraform/OpenTofu ler os valores necessários:

```bash
export TF_VAR_gcp_project="ID-DO-PROJETO"
export TF_VAR_ssh_user="seu-usuario"
export TF_VAR_ssh_public_key="$(< ~/.ssh/id_ed25519.pub)"
```

Se você usa outro nome de arquivo, ajuste o caminho da chave pública.

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
      └── compute/               # Módulo Compute Engine
            ├── instance.tf        # Recurso google_compute_instance
            ├── variables.tf       # Variáveis do módulo
            ├── output.tf          # Outputs do módulo
            ├── provider.tf        # Configuração do provider
            └── datasource.tf      # Lookup da imagem Debian
```

## 🔧 Variáveis Principais

### Requeridas
- `gcp_project`: ID do projeto GCP.

### Opcionais com Defaults
- `instance_count`: Número de instâncias (padrão: 1).
- `instance_type`: Tipo de máquina (padrão: e2-micro).
- `gcp_image`: Imagem Debian 13 por padrão.

### Obrigatórias para SSH
- `gcp_ssh_user`: Nome do usuário SSH.
- `gcp_ssh_public_key`: Chave pública SSH.

## 📊 Outputs

Após aplicar, você terá acesso a:
- `instance_public_ips`: IP público da instância.

Conecte-se através do comando `ssh -i ~/.ssh/gcp seu-usuario@ip-da-instancia`