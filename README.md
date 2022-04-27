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
- [x] init dynamic hosts include terraform 
  - [x] create variables vm/vds example <br>
    resource.yml 
    ```yaml
        master-node-1-dev:
          - name: "master-node-1-dev"
            source: "http://cloud-images-archive.ubuntu.com/releases/focal/release-20200423/ubuntu-20.04-server-cloudimg-amd64.img"
            memory: "2048"
            vcpu: 2
            size: 10737418240
            configuration: 
              name: simple
              passwd: 191351wq
              ssh-keys:
                "ssh-rsa key"
    ```
    output_vars.yml
  - [x] dynamic vars in include terraform
    ```yaml 
    ansible_host: ip_terraform vm/vds
    domain: "example.com"
    ```
  - [x] variables for roles and playbooks <br>
    var.yml
    ```yml
    swap:
      size: 2048
    ```
  - [x] create python scripts for generate output_vars.yml
- [ ] set static groups 
- [ ] ci/cd 
- [ ] metrics

terraform + nixos
- [ ] create build img for cloud/vm
  - [x] single nixos kvm 
  - [ ] multiple nixos kvm
  - [ ] deploy img nixos in cloud
- [ ] create resource docker-registry/kubernetes 
- [ ] configuration kubernetes 
- [ ] ci/cd 
- [ ] metrics
