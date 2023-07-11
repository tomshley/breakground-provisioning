ROOT_DIR="$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/"

export DOCKER_BUILDKIT=1
export DOCKER_CLI_EXPERIMENTAL=enabled
export BUILDKIT_PROGRESS=plain

current_arch := $(shell uname -m)
export ARCH ?= $(shell case $(current_arch) in (x86_64) echo "amd64" ;; (i386) echo "386";; (aarch64|arm64) echo "arm64" ;; (armv6*) echo "arm/v6";; (armv7*) echo "arm/v7";; (ppc64*|s390*|riscv*) echo $(current_arch);; (*) echo "UNKNOWN-CPU";; esac)
# export ARCH=amd64

check_cli = type "$(1)" >/dev/null 2>&1 || { echo "Error: command '$(1)' required but not found. Exiting." ; exit 1 ; }
check_image = make --silent list | grep -w '$(1)' >/dev/null 2>&1 || { echo "Error: the image '$(1)' does not exist in manifest for the platform 'linux/$(ARCH)'. Please check the output of 'make list'. Exiting." ; exit 1 ; }
bake_use := docker buildx bake -f docker-bake.hcl

check-reqs:
	@$(call check_cli,bash)
	@$(call check_cli,git)
	@$(call check_cli,docker)
	@docker info | grep 'buildx:' >/dev/null 2>&1 || { echo "Error: Docker BuildX plugin required but not found. Exiting." ; exit 1 ; }

setup:
	export DOCKER_CLI_EXPERIMENTAL=enabled && \
	export DOCKER_BUILDKIT=1

build: setup check-reqs
	docker buildx bake "os" && \
	docker buildx bake "provisioning"

push:
	docker buildx bake "os" --push && \
	docker buildx bake "provisioning" --push


publish-core: build-core push-core
build-all: build-core build-bootstrap
deploy-all: push-core push-bootstrap
