
.PHONY: shell

shell:
	nix-shell

show_virt:
	@sudo virsh list

show_ips:
	@terraform -chdir=terraform/kvm refresh  &&  terraform -chdir=terraform/kvm output | grep 10.225.1 | sed 's/"//' | sed 's/",//' | tr -s '[:space:]' "\n"


up_kvm:
	@terraform -chdir=terraform/kvm plan  &&  terraform -chdir=terraform/kvm apply 

down_kvm:
	@terraform -chdir=terraform/kvm destroy



	