#!/usr/bin/make -f

# 2026-01-10	Jud Cole Astro portfolio Web site make configuration

LOCAL_FOLDER := build
REMOTE_FOLDER := jc-portfolio
REMOTE_HOST := fd-debian-scw
REMOTE_PATH := /data/nginx/www

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

# check: @ Check all source files for errors
check: packages
	${PACKAGER} check
	${PACKAGER} lint

# clean: @ Clean up all generated files
clean:
	# ${PACKAGER} cache clean
	${PACKAGER} clean

# deploy: @ Build and deploy the Web site to the live site
deploy: build
	rsync -r -v ${LOCAL_FOLDER}/ ${REMOTE_HOST}:${REMOTE_PATH}/${REMOTE_FOLDER}

# dev: @ Serve the Web site on localhost and watch for changes
dev: packages
	${PACKAGER} dev

# format: @ Format all source files
format: packages
	${PACKAGER} format

# install: @ Install package manager and all package dependencies
install:
ifneq ($(NVM_INSTALLED),0)
	@echo "NVM not installed"
	# Install latest npm
	# ${NVM} install --lts --latest-npm
endif
	@if ! [ $$(command -v corepack) ]; then npm install --global corepack@latest; corepack --version; fi
ifeq ($(PACKAGER), yarn)
	@if ! [ $$(command -v ${PACKAGER}) ]; then corepack enable ${PACKAGER}; corepack use pnpm@latest-10; corepack ${PACKAGER} --version; fi
	@if [ -z "$$(${PACKAGER} list astro)" ]; then ${PACKAGER} install; fi
else ifeq ($(PACKAGER), pnpm)
	@if ! [ $$(command -v ${PACKAGER}) ]; then corepack enable ${PACKAGER}; corepack use pnpm@latest-10; corepack ${PACKAGER} --version; fi
	@if [ -z "$$(${PACKAGER} list astro)" ]; then ${PACKAGER} install; fi
endif

# Sub-task to install dependent packages
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
