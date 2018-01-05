provider "digitalocean" {
  token = "${var.do_token}"
}

data "template_file" "compose-file" {
  template = "${var.use_letsencrypt == "true" ? file("${path.module}/files/docker-compose-letsencrypt.yml") : file("${path.module}/files/docker-compose.yml")}"

  vars {
    portainer_version    = "${var.portainer_version}"
    portainer_parameters = "${var.portainer_parameters}"
    portainer_data_path  = "${var.portainer_data_path}"
    domain               = "${var.domain}"
    letsencrypt_test     = "${var.letsencrypt_test}"
    letsencrypt_email    = "${var.letsencrypt_email}"
    letsencrypt_keysize  = "${var.letsencrypt_keysize}"
  }
}

resource "digitalocean_droplet" "node" {
  ssh_keys           = "${var.ssh_keys}"
  image              = "${var.droplet_image}"
  region             = "${var.region}"
  user_data          = "${var.user_data}"
  size               = "${var.size}"
  private_networking = true
  backups            = "${var.backups}"
  ipv6               = false
  tags               = ["${var.tags}"]
  name               = "${format("%s.%s.%s", var.name, var.region, var.domain)}"
}

resource "null_resource" "compose_up" {
  triggers {
    compose_content = "${data.template_file.compose-file.rendered}"
    droplet         = "${digitalocean_droplet.node.id}"
  }

  connection {
    type        = "ssh"
    user        = "${var.provision_user}"
    private_key = "${file("${var.provision_ssh_key}")}"
    timeout     = "2m"
    host        = "${digitalocean_droplet.node.ipv4_address}"
  }

  provisioner "file" {
    content     = "${data.template_file.compose-file.rendered}"
    destination = "~/docker-compose.yml"
  }

  provisioner "remote-exec" {
    inline = [
      "${var.docker_compose_cmd} -p portainer -f ~/docker-compose.yml up -d --remove-orphans",
    ]
  }
}
