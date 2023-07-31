#TODO: Needs a lot of cleaning and more targets
# Copyright (c) 2023 Hidden Hound Security LLC.
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

_local-dev:
	vagrant up

_kill-local-dev:
	vagrant destroy -f --parallel

_builder-setup:
	docker build -t ansibleworker:1.0 ansible/
	docker run --rm  -v ${ROOT_DIR}/ansible:/etc/ansible -v ${ROOT_DIR}/playbooks:/playbooks ansibleworker:1.0 ansible-galaxy install --roles-path /etc/ansible/roles -r /etc/ansible/requirements.yml

prod-run: _builder-setup
	docker run --rm  -v ${ROOT_DIR}/ansible:/etc/ansible -v ${ROOT_DIR}/playbooks:/playbooks ansibleworker:1.0 ansible-playbook hashistack.yml

prod-restart: _builder-setup
	docker run --rm  -v ${ROOT_DIR}/ansible:/etc/ansible -v ${ROOT_DIR}/playbooks:/playbooks ansibleworker:1.0 ansible-playbook restart.yml

localdev-run: _builder-setup
	docker run --rm  -v ${ROOT_DIR}/ansible:/etc/ansible -v ${ROOT_DIR}/playbooks:/playbooks ansibleworker:1.0 ansible-playbook hashistack.yml

localdev-restart: _builder-setup
	docker run --rm  -v ${ROOT_DIR}/ansible:/etc/ansible -v ${ROOT_DIR}/playbooks:/playbooks ansibleworker:1.0 ansible-playbook restart.yml