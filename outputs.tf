output "droplet_id" {
  value       = "${digitalocean_droplet.node.id}"
  description = "ID of the droplet created"
}

output "ipv4_address" {
  value       = "${digitalocean_droplet.node.ipv4_address}"
  description = "Public ipv4 address of the droplet created"
}

output "ipv4_address_private" {
  value       = "${digitalocean_droplet.node.ipv4_address_private}"
  description = "Private ipv4 address of the droplet created"
}
