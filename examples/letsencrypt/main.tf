variable "do_token" {}

variable "ssh_keys" {
  type = "list"
}

variable "domain" {}

variable "sub_domain" {
  default = "portainer"
}

variable "letsencrypt_email" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

module "portainer" {
  region            = "nyc1"
  source            = "./../../"
  do_token          = "${var.do_token}"
  ssh_keys          = ["${var.ssh_keys}"]
  domain            = "${var.sub_domain}.${var.domain}"
  use_letsencrypt   = "true"
  letsencrypt_test  = "true"
  droplet_image     = "docker-16-04"
  letsencrypt_email = "${var.letsencrypt_email}"
}

resource "digitalocean_domain" "domain" {
  name       = "${var.domain}"
  ip_address = "${module.portainer.ipv4_address}"
}

resource "digitalocean_record" "portainer" {
  domain = "${var.domain}"
  type   = "A"
  ttl    = "60"
  name   = "${var.sub_domain}"
  value  = "${module.portainer.ipv4_address}"
}
