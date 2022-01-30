
locals {
  hosts = concat(var.hosts,
    module.config.map_configs.master-node-1-dev,
    module.config.map_configs.master-node-2-dev,
  )
}


variable "hosts" {
  type = list(object({
    name   = string
    source = string
    memory = string
    vcpu   = number
    size   = number
    configuration = object({
      name     = string
      passwd   = string
      ssh-keys = list(string)
    })
  }))
  default = [
    # {
    #   name   = "master-node"
    #   source = "http://cloud-images-archive.ubuntu.com/releases/focal/release-20200423/ubuntu-20.04-server-cloudimg-amd64.img"
    #   memory = "4048"
    #   vcpu   = 4
    #   size   = 20737418240
    #   configuration = {
    #     name     = " "
    #     passwd   = " "
    #     ssh-keys = [""]
    #   }
    # }
  ]
}







