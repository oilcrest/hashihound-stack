#TODO: Needs a lot of cleaning and more targets
# Copyright (c) 2023 Hidden Hound Security LLC.
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

_vagrant-up:
	vagrant up

build-docker:
	docker build -t ansibleworker:1.0 ansible/
	docker run --rm -v ${ROOT_DIR}/ansible:/etc/ansible -v ${ROOT_DIR}/playbooks:/playbooks ansibleworker:1.0 ansible-galaxy install --roles-path /etc/ansible/roles -r /etc/ansible/requirements.yml

prod-run: build-docker
	docker run --rm -v ${ROOT_DIR}/inventory/prod/:/inventory/ -v ${ROOT_DIR}/ansible:/etc/ansible -v ${ROOT_DIR}/playbooks:/playbooks ansibleworker:1.0 ansible-playbook hashistack.yml

prod-restart: build-docker
	docker run --rm -v ${ROOT_DIR}/inventory/prod/:/inventory/ -v ${ROOT_DIR}/ansible:/etc/ansible -v ${ROOT_DIR}/playbooks:/playbooks ansibleworker:1.0 ansible-playbook restart.yml

localdev-up: _vagrant-up build-docker

localdev-fullrun: localdev-up localdev-run

localdev-run: 
	docker run --rm -v ${ROOT_DIR}/vagrant-hostfile:/etc/hosts -v ${ROOT_DIR}/inventory/localdev/:/inventory/ -v ${ROOT_DIR}/ansible:/etc/ansible -v ${ROOT_DIR}/playbooks:/playbooks -v ${ROOT_DIR}/vagrant-hostfile:/etc/hosts ansibleworker:1.0 ansible-playbook hashistack.yml

localdev-fullshell: localdev-up localdev-shell

localdev-shell: 
	docker run -it --rm -v ${ROOT_DIR}/vagrant-hostfile:/etc/hosts -v ${ROOT_DIR}/inventory/localdev/:/inventory/ -v ${ROOT_DIR}/ansible:/etc/ansible -v ${ROOT_DIR}/playbooks:/playbooks -v ${ROOT_DIR}/vagrant-hostfile:/etc/hosts ansibleworker:1.0

localdev-down:
	vagrant destroy -f --parallel