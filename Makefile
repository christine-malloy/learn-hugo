.PHONY: server build clean mod

# Start the Hugo server with draft content included
server:
	hugo server --buildDrafts --buildFuture --navigateToChanged

# Build the site with draft content included
build:
	hugo --buildDrafts --buildFuture

# Build the site for production (no drafts)
build-prod:
	hugo

# Clean the build directory
clean:
	rm -rf public/

mod:
	thing:
		
	hugo mod tidy	
	hugo mod vendor
	hugo mod verify
	hugo mod get -u ./...
