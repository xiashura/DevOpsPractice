# This project my practice DevOps <br> 
## technology stack

* terraform (kvm,aws)
  * kvm for local testing infrastructure
  * aws prod 
* ansible 
* k8s
  * docker_registry
* metrics (grafana/prometheus)/ELK

<h1> Tasks: </h1> 
ansible + python + terraform

- [x] create role docker-registry/kubernetes 
- [x] set hostname cloud image
- [ ] init dynamic hosts include terraform 
  - [ ] create variables vm/vds example <br>
    resource.yml 
    ```yaml
        name: "master-node"
        source: "http://cloud-images-archive.ubuntu.com/releases/focal/release-20200423/ubuntu-20.04-server-cloudimg-amd64.img"
        memory: "4048"
        vcpu: 4
        size: 20737418240
        group: master-nodes-dev
      }
    ```
    output_vars.yml
  - [ ] dynamic vars in include terraform
    ```yaml 
    ansible_host: ip_terraform vm/vds
    domain: "example.com"
    ```
  - [ ] variables for roles and playbooks <br>
    var.yml
    ```yml
    swap:
      size: 2048
    ```
- [ ] set static groups 
- [ ] ci/cd 
- [ ] metrics

terraform + nixos
- [ ] create build img for cloud/vm
- [ ] create resource docker-registry/kubernetes 
- [ ] configuration kubernetes 
- [ ] ci/cd 
- [ ] metrics

