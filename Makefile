SHELL := /bin/bash

.PHONY: server build clean mod deploy tf-context tf-init tf-plan tf-apply tf-destroy

AWS_REGION := us-east-2
TF_BASE_DIR := infra
TF_STATE_BUCKET := greenmonkeytown-terraform-state

# Define the terraform directory dynamically
TF_DIR := $(shell ls $(TF_BASE_DIR) | grep "^terraform-" | head -n 1)

# Define a function to setup terraform workspace
define setup_terraform_workspace
	cd $(TF_BASE_DIR)/$(TF_DIR) && \
	WORKSPACE=$$(basename $$(pwd)) && \
	terraform workspace select $$WORKSPACE || terraform workspace new $$WORKSPACE
endef

# Start the Hugo server with draft content included
server:
	hugo server --buildDrafts --buildFuture --navigateToChanged

# Build the site with draft content included
build-dev:
	hugo --buildDrafts --buildFuture

# Build the site for production (no drafts)
build-prod:
	hugo --minify

deploy-dev:
	hugo deploy --target dev --invalidateCDN --force

deploy-prod:
	hugo deploy --target production --maxDeletes -1 --confirm --invalidateCDN --force

# Clean the build directory
clean:
	rm -rf public/

mod:
	hugo mod tidy	
	hugo mod vendor
	hugo mod verify
	hugo mod get -u ./...

# Download and update context.tf from cloudposse/terraform-null-label
tf-context:
	@echo "Fetching latest version..."
	@LATEST_VERSION=$$(curl -s https://api.github.com/repos/cloudposse/terraform-null-label/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'); \
	echo "Latest version: $$LATEST_VERSION"; \
	curl -o infra/terraform-aws-hugo-site/context.tf https://raw.githubusercontent.com/cloudposse/terraform-null-label/$$LATEST_VERSION/exports/context.tf; \
	echo "Downloaded context.tf version $$LATEST_VERSION"

tf-fmt:
	$(call setup_terraform_workspace) && \
	terraform fmt --recursive

tf-validate:
	$(call setup_terraform_workspace) && \
	terraform validate

tf-init:
	$(call setup_terraform_workspace) && \
	terraform init -upgrade -var-file=env/dev/default.tfvars -var-file=env/dev/website.tfvars

tf-plan:
	$(call setup_terraform_workspace) && \
	terraform plan -var-file=env/dev/default.tfvars -var-file=env/dev/website.tfvars

tf-apply:
	$(call setup_terraform_workspace) && \
	terraform apply --auto-approve -var-file=env/dev/default.tfvars -var-file=env/dev/website.tfvars

tf-destroy:
	$(call setup_terraform_workspace) && \
	terraform destroy --auto-approve -var-file=env/dev/default.tfvars -var-file=env/dev/website.tfvars