# LetsEncrypt

The Terraform configuration in this directroy creates a droplet running Portainer behind Nginx and configures LetsEncrypt using test certificates.

It will create a domain with an A record that resolves to the public IP address from the created droplet. This is necessary for LetsEncrypt to work.

Note that this example using DigitalOcean to configure a DNS record. You may have to adjust this example to your own needs.

## Usage

Configure the following variables (for example using `terraform.tfvars`):

```tf
ssh_keys = [SSH_KEY_ID]
domain = "mydomain.example"
use_letsencrypt = "true"
letsencrypt_test = "true"
letsencrypt_email = "letsencrypt-email@mydomain.example"
```

Replace the value of domain and the email address by your own values. Remember to set the ssh key ids correctly.

After this, run the following commands:

```bash
terraform init
terraform plan
terraform apply
```

This will take a couple of minutes to complete. Once done, you can visit https://portainer.mydomain.example in your browser. 
