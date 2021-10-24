
show_ips:
	@cd ./terraform/kvm && terraform output | grep 10.225.1 | sed 's/"//' | sed 's/",//' | tr -s '[:space:]' "\n"
