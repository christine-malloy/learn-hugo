TERRAFORM_DIR := infra/terraform-aws-hugo-site
WORKSPACE_NAME := terraform-aws-hugo-site

.PHONY: all help init workspace validate fmt fmt-fix plan apply destroy output

all: plan

help:
	@echo "Terraform Project Management"
	@echo "Commands:"
	@echo "  all         : Run validate and plan (default)"
	@echo "  help        : Show this help message"
	@echo "  init        : Initialize Terraform"
	@echo "  workspace   : Create/select '$(WORKSPACE_NAME)' workspace"
	@echo "  validate    : Validate configuration"
	@echo "  fmt         : Check formatting"
	@echo "  fmt-fix     : Fix formatting"
	@echo "  plan        : Generate execution plan"
	@echo "  apply       : Apply changes (with confirmation)"
	@echo "  destroy     : Destroy infrastructure (with confirmation)"
	@echo "  output      : Show outputs"

init:
	@echo "Initializing Terraform..."
	@cd $(TERRAFORM_DIR) && terraform init -backend-config="./env/prod/config.hcl"

workspace: init
	@echo "Ensuring workspace '$(WORKSPACE_NAME)' exists..."
	@cd $(TERRAFORM_DIR) && \
		(terraform workspace select $(WORKSPACE_NAME) 2>/dev/null || \
		terraform workspace new $(WORKSPACE_NAME)) && \
		terraform workspace show

validate: init
	@echo "Validating configuration..."
	@cd $(TERRAFORM_DIR) && terraform validate

fmt:
	@echo "Checking formatting..."
	@cd $(TERRAFORM_DIR) && terraform fmt -check

fmt-fix:
	@echo "Fixing formatting..."
	@cd $(TERRAFORM_DIR) && terraform fmt -recursive

plan: validate workspace
	@echo "Generating execution plan..."
	@mkdir -p .tfplan
	@touch .tfplan/$(WORKSPACE_NAME).tfplan
	@cd $(TERRAFORM_DIR) && terraform plan -out=./../../.tfplan/$(WORKSPACE_NAME).tfplan

apply: workspace
	@echo "Are you sure you want to apply changes? Type 'yes' to proceed."
	@read -p "Enter 'yes' to confirm: " CONFIRM && [ "$$CONFIRM" = "yes" ] || exit 1
	@cd $(TERRAFORM_DIR) && terraform apply ./../../.tfplan/$(WORKSPACE_NAME).tfplan

destroy: workspace
	@echo "DESTROY ALL RESOURCES IN WORKSPACE '$(WORKSPACE_NAME)'? Type 'yes' to proceed."
	@read -p "Enter 'yes' to confirm: " CONFIRM && [ "$$CONFIRM" = "yes" ] || exit 1
	@cd $(TERRAFORM_DIR) && terraform destroy

output:
	@cd $(TERRAFORM_DIR) && terraform output