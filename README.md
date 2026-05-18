<h2>Terraform-Scripts</h2>

<p align="center">
    <img alt="License" src="https://img.shields.io/badge/License-GPLv3-blue.svg?style=for-the-badge" />
    <img alt="Terraform" src="https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white" />
    <img alt="OpenTofu" src="https://img.shields.io/badge/OpenTofu-FFDA18?logo=opentofu&logoColor=000&style=for-the-badge" />
</p>

Este repositório é um **agregador dos meus códigos Terraform**: um conjunto de exemplos, módulos e scripts auxiliares para provisionar infraestrutura em diferentes provedores de nuvem.

O objetivo aqui é centralizar (em um só lugar) configurações reutilizáveis, variações por provider e pequenos scripts de pós-provisionamento, facilitando testes e reaproveitamento.

## Estrutura

- `AWS/`: exemplos e módulos para AWS (ex.: EC2) e scripts auxiliares.
- `DO/`: exemplos e módulos para DigitalOcean (droplets) e cloud-init.
- `Linode/`: exemplos e módulos para Linode e scripts auxiliares.
- `OCI/`: exemplos e módulos para Oracle Cloud Infrastructure (OCI).

Cada provider costuma seguir o mesmo padrão:

- `main.tf`, `variables.tf`, `output.tf`: composição do stack.
- `modules/`: módulos reutilizáveis.
- `scripts/`: scripts de bootstrap (ex.: nginx, cloud-init).

## Como usar

1. Entre no diretório do provider desejado (ex.: `AWS/`, `DO/`, `Linode/` ou `OCI/`).
2. Siga as instruções presentes no `README.md` para configuração do ambiente.
3. Execute:

   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## Notas

- Alguns diretórios incluem scripts de pós-provisionamento em `scripts/` para facilitar bootstrap de instâncias.

