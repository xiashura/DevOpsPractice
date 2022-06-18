
Role kubeadm
=========

A brief description of the role goes here.

Requirements
------------
TODO

Role Variables
--------------
- apiserver_cert_extra_sans ip/domain 
- group_name_master name group have master node for kubeadm
- group_name_worker name group have worker nodes for kubeadm

Dependencies
------------

Before run kubeadm need roles package/docker  package/k8s  package/python or run playbook init-k8s.yml

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:
```yaml
  - hosts: dev
    roles:
      - role: kubeadm
        vars:
          apiserver_cert_extra_sans: 192.168.0.102,10.0.223.1,example.k8s.com
          group_name_master: master-nodes-dev
          group_name_worker: worker-nodes-dev
```