
.PHONY: shell

shell:
	nix-shell

show_virt:
	@sudo virsh list

show_ips:
	@cd ./terraform/kvm && terraform refresh &&  terraform output | grep 10.225.1 | sed 's/"//' | sed 's/",//' | tr -s '[:space:]' "\n"


up_kvm:
	@cd ./terraform/kvm && terraform plan && terraform apply 

down_kvm:
	@cd ./terraform/kvm && terraform destroy