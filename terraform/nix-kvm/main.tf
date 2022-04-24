
terraform {
  required_version = ">= 0.13"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      // version = "0.6.3"
    }
  }
}

provider "libvirt" {
  uri = "qemu+ssh://xi@192.168.0.102/system?keyfile=/home/xi/.ssh/id_rsa.pub"
}

resource "libvirt_pool" "volumetmp" {
  name = "nixos-pool"
  type = "dir"
  path = "/var/tmp/nixos-pool"
}

resource "libvirt_volume" "base" {
  name   = "nixos"
  source = "/run/media/xi/5ef9c629-7e51-4304-8905-ab25a93edbae1/nixos.qcow2"
  pool   = libvirt_pool.volumetmp.name
  format = "qcow2"
}


resource "libvirt_volume" "vm-disk" {
  name           = "nixos.qcow2"
  base_volume_id = libvirt_volume.base.id
  pool           = libvirt_pool.volumetmp.name
  format         = "qcow2"
}

resource "libvirt_domain" "machine" {

  name     = "vm1"
  vcpu     = 2
  memory   = 2048

  disk {
    volume_id = libvirt_volume.vm-disk.id
  }

  graphics {
    listen_type = "address"
  }

  # dynamic IP assignment on the bridge, NAT for Internet access
  network_interface {
    network_name   = "default"
    wait_for_lease = true
  }
}

output "ip-addresses" {
  value = libvirt_domain.machine.network_interface.0.addresses.*
}