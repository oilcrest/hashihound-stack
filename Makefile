# Copyright (c) 2023 Hidden Hound Security LLC.
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

local-dev:
		vagrant up

kill-local-dev:
		vagrant destroy -f --parallel

run-builder:
		docker build -t ansibleworker:1.0 ansible/
		docker run --rm  -v ${ROOT_DIR}/ansible:/etc/ansible -v ${ROOT_DIR}/playbooks:/playbooks --name hashihound-ansibleworker ansibleworker:1.0 ansible-galaxy install --roles-path /etc/ansible/roles -r /etc/ansible/requirements.yml
		docker run --rm  -v ${ROOT_DIR}/ansible:/etc/ansible -v ${ROOT_DIR}/playbooks:/playbooks --name hashihound-ansibleworker ansibleworker:1.0 ansible-playbook hashistack.yml