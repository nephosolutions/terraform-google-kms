#  Copyright 2022 NephoSolutions srl
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

.DEFAULT_GOAL := .terraform.lock.hcl

WORKSPACES := $(dir $(shell find . -mindepth 2 -type l -name Makefile ! -path "*/.terraform/*"))

remove		= $(if $(strip $1),rm -rf $(strip $1))

terraform_dir 	= $(wildcard .terraform)
terraform_dirs	= $(wildcard modules/*/.terraform)
terraform_locks	= $(wildcard modules/*/.terraform.lock.hcl)
terraform_plans	= $(wildcard *tfplan*)

clean: $(WORKSPACES)
	$(call remove,$(terraform_dir))
	$(call remove,$(terraform_dirs))
	$(call remove,$(terraform_locks))
	$(call remove,$(terraform_plans))

console plan: .terraform
	terraform $@

.terraform init:
	terraform init

.terraform.lock.hcl: .terraform
	terraform providers lock -platform=darwin_amd64 -platform=darwin_arm64 -platform=linux_amd64 -platform=windows_amd64

$(WORKSPACES):
	$(MAKE) -C $@ $(if $(filter clean,$(MAKECMDGOALS)),clean)

.PHONY: .terraform.lock.hcl $(WORKSPACES)
