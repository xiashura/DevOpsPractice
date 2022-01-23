

output "ips" {
  value = libvirt_domain.hosts.*.network_interface.0.addresses.0
}

output "domain" {
  value = libvirt_domain.hosts.*.name
}

output "hosts" {
  value = join("\n", toset([
    for host in libvirt_domain.hosts : format("%s %s", host.name, host.network_interface.0.addresses.0)
    ])
  )
}

output "hosts-ansible" {
  value = join("\n", toset([
    for host in libvirt_domain.hosts : format("%s ansible_host=%s ansible_user=root", host.name, host.network_interface.0.addresses.0)
    ])
  )
}
