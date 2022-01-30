

# output "map_configs" {
#   value       = module.config.map_configs
#   description = "Terraform maps from YAML configurations"
# }

# output "list_configs" {
#   value       = module.config.list_configs
#   description = "Terraform lists from YAML configurations"
# }

# output "all_imports_list" {
#   value       = module.config.all_imports_list
#   description = "List of all imported YAML configurations"
# }

# output "all_imports_map" {
#   value       = module.config.all_imports_map
#   description = "Map of all imported YAML configurations"
# }




# output "ips" {
#   value = libvirt_domain.hosts.*.network_interface.0.addresses.0
# }

# output "ip" {
#   value = libvirt_domain.hosts.*.network_interface.0.addresses.0[0]
# }

# output "domain" {
#   value = libvirt_domain.hosts.*.name
# }

output "hosts" {
  value = join("\n", toset([
    for host in libvirt_domain.hosts : format("%s %s", host.name, host.network_interface.0.addresses.0)
    ])
  )
}

# output "hosts-ansible" {
#   value = join("\n", toset([
#     for host in libvirt_domain.hosts : format("%s ansible_host=%s ansible_user=root", host.name, host.network_interface.0.addresses.0)
#     ])
#   )
# }
