# Makefile for aptworld project

APP_NAME=aptworld
VERSION=1.0.0
DEB_DIR=build_deb
DEB_FILE=$(APP_NAME)_$(VERSION).deb

.PHONY: run docker build install clean

# Run the Python script directly (on Debian system)
run:
	python3 $(APP_NAME).py

# Build and run the script inside a Docker container (Debian 12)
docker:
	docker build -t $(APP_NAME) .
	docker run --rm -v "$$PWD:/app" $(APP_NAME)

# Build the .deb package
build:
	chmod +x $(APP_NAME).py
	mkdir -p $(DEB_DIR)/DEBIAN
	mkdir -p $(DEB_DIR)/usr/local/bin
	cp $(APP_NAME).py $(DEB_DIR)/usr/local/bin/$(APP_NAME)
	echo "Package: $(APP_NAME)\nVersion: $(VERSION)\nSection: utils\nPriority: optional\nArchitecture: all\nDepends: python3\nMaintainer: Jake Mofa <you@email.com>\nDescription: CLI tool that lists explicitly installed Debian packages." > $(DEB_DIR)/DEBIAN/control
	dpkg-deb --build --root-owner-group $(DEB_DIR) $(DEB_FILE)

# Install the .deb package
install: build
	sudo dpkg -i $(DEB_FILE)

# Clean generated files
clean:
	rm -rf $(DEB_DIR) $(DEB_FILE) listofpackages.json
