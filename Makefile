.ONESHELL:

SHELL := /bin/bash

apply:
	echo "Calling  apply for windowsvm"
	terraform init
	terraform plan -var-file="examples/windows-vm.tfvars"
	terraform apply -var-file="examples/windows-vm.tfvars" -auto-approve
destroy:
	terraform destroy -var-file="examples/windows-vm.tfvars" -auto-approve
clean:
	@find . -name terraform.tfstate -type f -exec rm -rf {} +
	@find . -name terraform.tfstate.backup -type f -exec rm -rf {} +
	@find . -name .terraform -type d -exec rm -rf {} +
	@find . -name .terraform.lock.hcl -type f -exec rm -rf {} +
	@find . -name providers -type d -exec rm -rf {} +