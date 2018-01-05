# Terraform DigitalOcean Portainer

Terraform module example for provisioning Portainer on DigitalOcean running behind Nginx with LetsEncrypt.

[![CircleCI](https://circleci.com/gh/thojkooi/terraform-digitalocean-portainer.svg?style=svg)](https://circleci.com/gh/thojkooi/terraform-digitalocean-portainer)

---

- [Goals](#goals)
- [Prerequisites](#prerequisites)
- [Usage](#usage)

## Goals

- Set up a single DigitalOcean droplet running Portainer
- Optionally configure a reverse proxy with LetsEncrypt to run infront of Portainer

## Prerequisites

- Terraform >= 0.10.8
- Digitalocean account / API token with write access
- SSH Public keys added to your DigitalOcean account
- When using LetsEncrypt, a domain name pointing to the created droplet and an email address. See [the LetsEncrypt example](https://github.com/thojkooi/terraform-digitalocean-portainer/tree/master/examples/letsencrypt).

## Usage

Create a new Terraform file (`main.tf`) and add the following contents:

```tf
variable "do_token" {}

module "portainer" {
  source   = "github.com/thojkooi/terraform-digitalocean-portainer"
  do_token = "${var.do_token}"

  size            = "512mb"
  name            = "portainer"
  region          = "ams3"
  domain          = "example.com"

  ssh_keys          = [1234, 1235, ...]
  provision_ssh_key = "~/.ssh/id_rsa"
}
```
Provide the ssh key ids on your DigitalOcean account. If you are using `doctl`, you can find the ids by running:
```bash
$ doctl compute ssh-key ls
```

Once done, run `terraform init` to download the necessary providers. When the providers have been downloaded run `terraform apply`. After this, you should be able to access the Portainer UI by visiting the public ip adres in your browser.

### LetsEncrypt

This module supports running Portainer behind Nginx with LetsEncrypt. An example on how to do this is [available in the examples directory](https://github.com/thojkooi/terraform-digitalocean-portainer/tree/master/examples/letsencrypt). By default, test certificates are requested.


### SSH Key

Terraform uses an SSH key to connect to the created droplets in order to issue `docker swarm join` commands. By default this uses `~/.ssh/id_rsa`. If you wish to use a different key, you can modify this using the variable `provision_ssh_key`. You also need to ensure the public key is added to your DigitalOcean account and it's ID is listed in the `ssh_keys` list.


### More information

- Read up on the Portainer [documentation](https://portainer.readthedocs.io/en/stable/index.html).
- View Terraform [DigitalOcean provider documentation](https://www.terraform.io/docs/providers/do/index.html).

## License

This module is licensed under [MIT](https://github.com/thojkooi/terraform-digitalocean-portainer/tree/master/LICENSE).
