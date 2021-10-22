
terraform {
 required_version = ">= 0.13"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

variable "vm_machines" {
  description = "Create machines with these names"
  type = list(string)
  default = ["master01", "worker01", "worker02"]
}

# We fetch the latest ubuntu release image from their mirrors
resource "libvirt_volume" "ubuntu" {
  name = "${var.vm_machines[count.index]}.qcow2"
  count = length(var.vm_machines)
  pool = "default"
  source = "http://cloud-images.ubuntu.com/releases/bionic/release-20191008/ubuntu-18.04-server-cloudimg-amd64.img"
  format = "qcow2"
}

# Create a network for our VMs
resource "libvirt_network" "vm_network" {
   name = "vm_network"
   addresses = ["10.224.1.0/24"]
   dhcp {
        enabled = true
   }
}

# Use CloudInit to add our ssh-key to the instance
resource "libvirt_cloudinit_disk" "commoninit" {
          name = "commoninit.iso"
          pool = "default"
          user_data = "${data.template_file.user_data.rendered}"
          network_config = "${data.template_file.network_config.rendered}"
        }

data "template_file" "user_data" {
  template = "${file("${path.module}/cloud_init.cfg")}"
}

data "template_file" "network_config" {
  template = "${file("${path.module}/network_config.cfg")}"
}


# Create the machine
resource "libvirt_domain" "ubuntu" {
  count = length(var.vm_machines)
  name = var.vm_machines[count.index]
  memory = "2048"
  vcpu = 2

  cloudinit = "${libvirt_cloudinit_disk.commoninit.id}"

  network_interface {
    network_id = "${libvirt_network.vm_network.id}"
    network_name = "vm_network"
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
       volume_id = libvirt_volume.ubuntu[count.index].id
  }
  graphics {
    type = "vnc"
    listen_type = "address"
    autoport = "true"
  }
}


output "ip" {
  value = libvirt_domain.ubuntu.*.network_interface.0.addresses
}

