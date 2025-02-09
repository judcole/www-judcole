#!/usr/bin/make -f

# 02/04/25 Jud Cole Astro portfolio Web site make configuration

HOST_REMOTE := fd-debian-scw
SITE_LOCAL := build
SITE_NAME := Jud Cole portfolio
SITE_REMOTE := jc-astro

CURRENT_DATE := $(shell date +%F)
CURRENT_DATE_TIME := $(shell date +%FT%T%Z)

NVM := ~/.nvm/nvm.sh
NVM_INSTALLED := $(shell test -f "$(HOME)/.nvm/nvm.sh"; echo $$?)
PACKAGER=pnpm

# spell-checker: ignore astrojs

# help: @ List the available make tasks
help:
	@grep -Eoh '[0-9a-zA-Z_\.\-]+:.*?@ .*' $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?@ "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' | sort

# build: @ Build the Web site
build: packages
	${PACKAGER} build

# clean: @ Clean up all generated files
clean:
	# ${PACKAGER} cache clean
	${PACKAGER} clean

# deploy: @ Build and deploy the Web site to the live site
deploy: build
	rsync -r -v ${SITE_LOCAL}/ ${HOST_REMOTE}:/var/www/${SITE_REMOTE}

# dev: @ Serve the Web site on localhost and watch for changes
dev: packages
	${PACKAGER} dev

# format: @ Format all source files
format: packages
	${PACKAGER} format

# install: @ Install package manager and other dependencies
install:
ifneq ($(NVM_INSTALLED),0)
	@echo "NVM not installed"
	# Install latest npm
	# ${NVM} install --lts --latest-npm
endif
ifeq ($(PACKAGER), yarn)
	@if ! [ $(command -v $(PACKAGER)) ]; then corepack $(PACKAGER) --version; fi
else ifeq ($(PACKAGER), pnpm)
	@if ! [ $(command -v $(PACKAGER)) ]; then corepack $(PACKAGER) --version; fi
	@if ! [ $(command -v astro) ]; then ${PACKAGER} install; fi
endif

# lint: @ Lint check all source files
lint: packages
	${PACKAGER} lint

# Dependent packages
packages: install
ifeq ($(PACKAGER), yarn)
	@if ! [ -f "yarn.lock" ]; then yarn install; fi
else ifeq ($(PACKAGER), pnpm)
	@if ! [ -f "pnpm-lock.yaml" ]; then ${PACKAGER} install; fi
endif

# preview: @ Build and preview the Web site on localhost
preview: build
	${PACKAGER} preview

# upgrade: @ Upgrade all packages to their latest versions
upgrade: packages
	${PACKAGER} upgrade --interactive --latest
	${PACKAGER} dlx @astrojs/upgrade

# zip: @ Zip up the unique source files
zip:
	-rm ${PWD}-$(CURRENT_DATE).7z
	7z a ${PWD}-$(CURRENT_DATE) -bt -mhe=on -mmt8 -mx9 -r '-x!.git' '-x!build' '-x!node_modules' '-x!*.7z' '-x!*.lock' .
