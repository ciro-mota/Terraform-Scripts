<h2>Digital Ocean</h2>

<p align="center">
    <img alt="DigitalOcean" src="https://img.shields.io/badge/DigitalOcean-0080FF?logo=digitalocean&logoColor=fff&style=for-the-badge" />
    <img alt="Terraform" src="https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white" />
    <img alt="OpenTofu" src="https://img.shields.io/badge/OpenTofu-FFDA18?logo=opentofu&logoColor=000&style=for-the-badge" />
    <img alt="Ansible" src="https://img.shields.io/badge/Ansible-000000?style=for-the-badge&logo=ansible&logoColor=white" />
    <img alt="AlmaLinux" src="https://img.shields.io/badge/AlmaLinux-000?logo=almalinux&logoColor=fff&style=for-the-badge" />
    <img alt="Rocky Linux" src="https://img.shields.io/badge/Rocky%20Linux-10B981?logo=rockylinux&logoColor=fff&style=for-the-badge" />
    <img alt="CentOS" src="https://img.shields.io/badge/CentOS-262577?logo=centos&logoColor=fff&style=for-the-badge" />
    <img alt="Debian" src="https://img.shields.io/badge/Debian-A81D33?style=for-the-badge&logo=debian&logoColor=white" />
    <img alt="Ubuntu" src="https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white" />
    <img alt="Shell Script" src="https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white" />
</p>


This project aims to provision Droplets on DigitalOcean with the help of Terraform or OpenTofu.

## ⚠️ Caution!

DigitalOcean charges you for the use of VMs [even if they are in a powered off state](https://www.digitalocean.com/pricing/droplets#general-faq) and this can cause a huge cost issue for some people. So you can never forget to `destroy` your instances after some testing.

## 📌 Before executing:

> [!NOTE]\
> It is necessary to get credentials for Terraform execution.

1. Create a [DigitalOcean Personal Access Token](https://docs.digitalocean.com/reference/api/create-personal-access-token/).

2. Create an `ssh key` to be used with DigitalOcean and [register it in the administration panel](https://www.digitalocean.com/docs/droplets/how-to/add-ssh-keys/to-account/).

3. We need to get your SSH key fingerprint. Run this command:

```bash
ssh-keygen -E md5 -lf ~/.ssh/your-keyname.pub | awk '{print $2}'|cut -d ':' -f2-
```

4. Add two variables to your `.bashrc` or `.zshrc` file:

```bash 
export TF_VAR_do_token=<your-personal-access-token>
export TF_VAR_ssh_fingerprint=<your-key-fingerprint>
```

## 💻 Usage

- Clone this repo.
- By default an Droplet with **Debian 12** with `s-1vcpu-2gb` will be provisioned, if you want another OS or machine, modify the `modules/droplets/variables.tf` files if you wish.
- Run `terraform init`, `terraform plan -out= name-of-the-plan` and `terraform apply`. At the end, `terraform destroy`

## 🔧 cloud-init 

You can also apply post-installation scripts to your DigitalOcean Droplets through `cloud-init`. This project counts as example scripts for `nginx` provisioning provided by Ansible Galaxy.

You can create your own script and insert it into the `content` field of the `cloud_init.yaml` file.

To work with these settings, uncomment line `11` in the `modules/droplets/instance.tf` file.

## 💾 Remote state

By default this block will be commented. Uncomment if you use it.

DigitalOcean Spaces Object Storage supports S3-compatible applications, so the `aws cli` is supported for file handling with DigitalOcean and remote states.

- Create a Spaces Object Storage bucket with your unique name.
- Browse to `API` » `Spaces Keys` » `Generate New Key`. Get your Access Key and Secret.
- Install `aws cli`.
- Run the command `aws configure --profile digitalocean` for configuration.
- When prompted, enter your previously obtained Access Key and Secret. The region and output fields can be left blank.
- Add the variable below to your `.bashrc` or `.zshrc`:

```bash
export AWS_PROFILE=digitalocean
```

- Uncomment and edit lines `11` and `13` of the `main.tf` file with the information about your bucket in which it was created.

## 🤝 Referral

Need fast and affordable cloud hosting? Try @digitalocean using my affiliate link and get free credits to get started:

[![DigitalOcean Referral Badge](https://web-platforms.sfo2.cdn.digitaloceanspaces.com/WWW/Badge%201.svg)](https://www.digitalocean.com/?refcode=59a80b08da11&utm_campaign=Referral_Invite&utm_medium=Referral_Program&utm_source=badge)
