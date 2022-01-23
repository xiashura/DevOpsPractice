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

resource "libvirt_pool" "hosts" {
  name = "hosts"
  type = "dir"
  path = "/tmp/terraform_hosts"
}


resource "libvirt_volume" "hosts_volume" {
  name   = "${var.hosts[count.index].name}.qcow2"
  count  = length(var.hosts)
  pool   = libvirt_pool.hosts.name
  source = var.hosts[count.index].source
  format = "qcow2"
}

resource "libvirt_volume" "hosts_volume_resize" {
  name           = "${var.hosts[count.index].name}_resize.qcow2"
  count          = length(var.hosts)
  base_volume_id = libvirt_volume.hosts_volume[count.index].id
  pool           = libvirt_pool.hosts.name
  size           = var.hosts[count.index].size
}

# Create a network for our VMs
resource "libvirt_network" "hosts_net" {
  name      = "hosts_net"
  addresses = ["10.223.1.0/24"]
  dhcp {
    enabled = true
  }
}

# Use CloudInit to add our ssh-key to the instance
resource "libvirt_cloudinit_disk" "commoninit" {
  name = "commoninit_${var.hosts[count.index].name}.iso"
  pool = libvirt_pool.hosts.name

  count          = length(var.hosts)
  user_data      = data.template_file.user_data[count.index].rendered
  network_config = data.template_file.network_config.rendered
}

data "template_file" "user_data" {
  count    = length(var.hosts)
  template = templatefile("${path.module}/cloud_init.cfg", var.hosts[count.index])
}

data "template_file" "network_config" {
  template = file("${path.module}/network_config.cfg")
}

resource "libvirt_domain" "hosts" {
  count  = length(var.hosts)
  name   = var.hosts[count.index].name
  memory = var.hosts[count.index].memory
  vcpu   = var.hosts[count.index].vcpu

  cloudinit = libvirt_cloudinit_disk.commoninit[count.index].id

  network_interface {
    network_id   = libvirt_network.hosts_net.id
    network_name = libvirt_network.hosts_net.name
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
    volume_id = libvirt_volume.hosts_volume_resize[count.index].id
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
