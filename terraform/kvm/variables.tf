variable "ubuntu_img_source_18_04" {
  type    = string
  default = "http://cloud-images.ubuntu.com/releases/bionic/release-20191008/ubuntu-18.04-server-cloudimg-amd64.img"
}


variable "centos_img_source" {
  type    = string
  default = "https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-GenericCloud-8.4.2105-20210603.0.x86_64.qcow2"
}


variable "hosts" {
  type = list(object({ name = string
    source = string
    memory = string
    vcpu   = number
    size   = number
  }))
  default = [
    {
      name   = "master-node"
      source = "http://cloud-images-archive.ubuntu.com/releases/focal/release-20200423/ubuntu-20.04-server-cloudimg-amd64.img"
      memory = "4048"
      vcpu   = 4
      size   = 20737418240
    }
    # ,
    # {
    #   name   = "worker-node-1"
    #   source = "http://cloud-images-archive.ubuntu.com/releases/focal/release-20200423/ubuntu-20.04-server-cloudimg-amd64.img"
    #   memory = "2048"
    #   vcpu   = 2
    #   size   = 10737418240
    # }
    # ,
    # { 
    # name = "node-2" 
    # source = "http://cloud-images.ubuntu.com/releases/bionic/release-20191008/ubuntu-18.04-server-cloudimg-amd64.img" 
    # memory = "2048" 
    # vcpu = 2 
    # size = 10737418240 
    # } 
  ]
}







