.PHONY: server build clean mod

# Start the Hugo server with draft content included
server:
	hugo server --buildDrafts --buildFuture --navigateToChanged

# Build the site with draft content included
build-dev:
	hugo --buildDrafts --buildFuture

# Build the site for production (no drafts)
build-prod:
	hugo

# Clean the build directory
clean:
	rm -rf public/

mod:
	hugo mod tidy	
	hugo mod vendor
	hugo mod verify
	hugo mod get -u ./...

# Download and update context.tf from cloudposse/terraform-null-label
context:
	@echo "Fetching latest version..."
	@LATEST_VERSION=$$(curl -s https://api.github.com/repos/cloudposse/terraform-null-label/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'); \
	echo "Latest version: $$LATEST_VERSION"; \
	curl -o infra/terraform-aws-hugo-site/context.tf https://raw.githubusercontent.com/cloudposse/terraform-null-label/$$LATEST_VERSION/exports/context.tf; \
	echo "Downloaded context.tf version $$LATEST_VERSION"