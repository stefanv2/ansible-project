ANSIBLE_CMD = ansible-playbook -i hosts.ini basic-setup.yml

all:
	$(ANSIBLE_CMD)

ping:
	ansible -i hosts.ini all -m ping

common:
	$(ANSIBLE_CMD) --tags common

nginx:
	$(ANSIBLE_CMD) --tags nginx

postgres:
	$(ANSIBLE_CMD) --tags postgres

zip:
	$(ANSIBLE_CMD) --tags zip

files:
	$(ANSIBLE_CMD) --tags files

restart:
	./restart.sh

create:
	sudo ./create_ubuntu.sh

list-tags:
	$(ANSIBLE_CMD) --list-tags

# Makefile

.PHONY: connect-%

connect-%:
	@echo "🔗 Verbinden met container: $*"
	sudo docker exec -it $* bash

