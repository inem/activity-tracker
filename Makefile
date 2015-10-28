# This file is only useful for users of Ubuntu (or other Debian based) OS

install_ansible:
	sudo apt-get install software-properties-common -y
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt-get update
	sudo apt-get install ansible -y

install_nfs:
	sudo apt-get install nfs-kernel-server nfs-common
# .PHONY:
