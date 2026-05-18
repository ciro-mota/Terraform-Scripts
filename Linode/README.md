<h2>Linode</h2>

<p align="center">
    <img alt="Linode" src="https://img.shields.io/badge/Linode-00A95C?style=for-the-badge&logo=Linode&logoColor=white" />
    <img alt="Terraform" src="https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white" />
    <img alt="OpenTofu" src="https://img.shields.io/badge/OpenTofu-FFDA18?logo=opentofu&logoColor=000&style=for-the-badge" />
    <img alt="Ansible" src="https://img.shields.io/badge/Ansible-000000?style=for-the-badge&logo=ansible&logoColor=white" />
    <img alt="Debian" src="https://img.shields.io/badge/Debian-A81D33?style=for-the-badge&logo=debian&logoColor=white" />
    <img alt="Ubuntu" src="https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white" />
    <img alt="AlmaLinux" src="https://img.shields.io/badge/AlmaLinux-000?logo=almalinux&logoColor=fff&style=for-the-badge" />
    <img alt="Rocky Linux" src="https://img.shields.io/badge/Rocky%20Linux-10B981?logo=rockylinux&logoColor=fff&style=for-the-badge" />
    <img alt="Shell Script" src="https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white" />
</p>


This project aims to provision instances on Linode with the help of Terraform.

## ⚠️ Caution!

Linode charges you for the use of VMs [even if they are in a powered off state](https://www.linode.com/docs/products/platform/billing/#will-i-be-billed-for-powered-off-or-unused-services) and this can cause a huge cost issue for some people. So you can never forget to `destroy` your instances after some testing.

## 📌 Before executing:

> [!NOTE]\
> It is necessary to get credentials for Terraform execution.

1. Create a [Linode Personal Access Token](https://www.linode.com/docs/products/tools/api/guides/manage-api-tokens/).

2. Add two variables to your `.bashrc` or `.zshrc` file:

```bash 
export TF_VAR_LINODE_CLI_TOKEN=<your-personal-access-token>
export TF_VAR_public_key_path=$(cat /home/your-username/.ssh/id_rsa.pub)
```

## 💻 Usage

- Clone this repo.
- By default an instance with **Debian 12** with `g6-nanode-1` will be provisioned, if you want another OS or machine modify the `modules/linode/variables.tf` files if you wish.
- Run `terraform init`, `terraform plan -out= name-of-the-plan` and `terraform apply`. At the end, `terraform destroy`.

> [!TIP]
> If you receive the following error when connecting to your instance:
> ```
> Received disconnect from 45.xx.xx.xx port 22:2: Too many authentication failures
> Disconnected from 45.xx.xx.xx port 22
> ```
> Run the following command to access:
> ```bash
> ssh -o IdentitiesOnly=yes root@45.xx.xx.xx -i .ssh/id_rsa.pub
>```

## 🔧 Stackscripts

You can also apply post-installation scripts to your Linode instance through Stackscripts. This project counts as example scripts for `nginx` provisioning provided by Ansible Galaxy.

You can create your own script and upload it to the instance via the `.sh` file that will be called on line 12 of the `modules/linode/resources.tf` file.

To work with these settings uncomment line `10` in the `modules/linode/instance.tf` file.

## 💾 Remote state

By default this block will be commented. Uncomment if you use it.

You must manually create a bucket in Object Storage and [create Access Keys](https://www.linode.com/docs/products/storage/object-storage/guides/access-keys/) for it.

Linode Object Storage supports S3-compatible applications, so the `aws cli` is supported for file handling with Linode.

- Install `aws cli`.
- Run the command `aws configure --profile linode` for configuration.
- When prompted, enter the `access_key_id` and `secret_access_key` provided values obtained earlier. The region field can be left blank.
- Add the same variables to your `.bashrc` or `.zshrc` file by filling them in with the Access Keys values obtained earlier:

```bash
export TF_VAR_access_key_id=<your credentials>
export TF_VAR_secret_access_key=<your credentials>
```

- Uncomment lines `8` to `13` of the `variables.tf` file.
- Uncomment and edit lines `11`, `17` and `19` of the `main.tf` file with the information about your bucket and the region in which it was created.
