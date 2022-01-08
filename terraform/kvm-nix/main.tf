terraform {
  required_version = ">= 0.13"
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_pool" "nix_os" {
  name = "nix_os"
  type = "dir"
  path = "/tmp/terraform_nix_os"
}


resource "libvirt_volume" "nix_volume" {
  name   = "nix_os.qcow2"
  pool   = libvirt_pool.nix_os.name
  source = "/home/xi2/Projects/devOpsPractics/terraform/kvm-nix/result/nixos.qcow2"

}

resource "libvirt_volume" "nix_volume_resize" {
  name           = "nix_os_resize.qcow2"
  base_volume_id = libvirt_volume.nix_volume.id
  pool           = libvirt_pool.nix_os.name
  size           = 10737418240
}

# Create a network for our VMs
resource "libvirt_network" "nix_os" {
  name      = "nix_os"
  addresses = ["10.224.1.0/24"]
  dhcp {
    enabled = true
  }
}


resource "libvirt_domain" "hosts" {
  name   = "test-nixos"
  memory = 2048
  vcpu   = 2


  network_interface {
    network_id   = libvirt_network.nix_os.id
    network_name = libvirt_network.nix_os.name
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = libvirt_volume.nix_volume_resize.id
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}

output "ips" {
  value = libvirt_domain.hosts.network_interface.*.addresses
}

