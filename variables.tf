variable "do_token" {}

variable "ssh_keys" {
  type = "list"
}

variable "portainer_version" {
  default     = "1.16.1"
  description = "Version of Portainer to run"
}

variable "portainer_parameters" {
  default     = "--no-analytics"
  description = "Parameters provided to Portainer upon start"
}

variable "domain" {
  description = "Domain name used in droplet host names, e.g example.com. When using LetsEncrypt, also the domain for which the certificates are requested. Ensure the DNS resolves to the ip address of the created droplet in that case."
}

variable "provision_ssh_key" {
  default     = "~/.ssh/id_rsa"
  description = "File path to SSH private key used to access the provisioned nodes. Ensure this key is listed in the manager and work ssh keys list"
}

variable "provision_user" {
  default     = "root"
  description = "User used to log in to the droplets via ssh for issueing Docker commands"
}

variable "droplet_image" {
  default     = "docker-16-04"
  description = "Image used when creating the droplet. Has to have Docker and docker-compose installed"
}

variable "user_data" {
  default     = ""
  description = "User data provided to droplet"
}

variable "docker_compose_cmd" {
  default     = "docker-compose"
  description = "Docker compose command to use on the created droplet. Use to make use of sudo, for example: 'sudo docker-compose'"
}

variable "region" {
  description = "Datacenter region in which the instance will be created"
  default     = "ams3"
}

variable "size" {
  description = "Droplet size"
  default     = "s-1vcpu-1gb"
}

variable "backups" {
  default     = false
  description = "Enable DigitalOcean droplet backups"
}

variable "name" {
  description = "Prefix for name of the created droplet"
  default     = "portainer"
}

variable "tags" {
  description = "List of DigitalOcean tag ids"
  default     = []
  type        = "list"
}

variable "use_letsencrypt" {
  default     = "false"
  description = "Deploy Portainer behind Nginx and use LetsEncrypt to generate certificates"
}

variable "letsencrypt_test" {
  default     = "true"
  description = "Create test certificates through LetsEncrypt"
}

variable "letsencrypt_email" {
  default     = ""
  description = "Email address to use when using LetsEncrypt. Must be provided when using letsencrypt"
}

variable "letsencrypt_keysize" {
  default     = "4096"
  description = "The size of the through LetsEncrypt requested key"
}

variable "portainer_data_path" {
  default     = "./portainer_data"
  description = "Location on the filesystem where the data from portainer is stored. When using LetsEncrypt, also stores the certificates."
}
