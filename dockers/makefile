#
# Copyright 2023 Tomshley LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# @author Thomas Schena @sgoggles <https://github.com/sgoggles> | <https://gitlab.com/sgoggles>
#

ROOT_DIR="$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/"

export DOCKER_BUILDKIT=1
export DOCKER_CLI_EXPERIMENTAL=enabled
export BUILDKIT_PROGRESS=plain

current_arch := $(shell uname -m)
export ARCH ?= $(shell case $(current_arch) in (x86_64) echo "amd64" ;; (i386) echo "386";; (aarch64|arm64) echo "arm64" ;; (armv6*) echo "arm/v6";; (armv7*) echo "arm/v7";; (ppc64*|s390*|riscv*) echo $(current_arch);; (*) echo "UNKNOWN-CPU";; esac)
build_version_tag := v$(shell cat ../VERSION | sed -r 's/^.{1}//')
export TOMSHLEY_DOCKERS_BUILD_PROJECT_NAME ?= breakground-provisioning
export TOMSHLEY_BREAKGROUND_DOCKERS_GROUPNAME ?= tomshley
export TOMSHLEY_DOCKERS_BUILD_REF ?= $(build_version_tag)

ifeq ($(TOMSHLEY_DOCKERS_BUILD_REF),$(build_version_tag))
    export TOMSHLEY_DOCKERS_BUILD_REF_LATEST ?= latest
else
    export TOMSHLEY_DOCKERS_BUILD_REF_LATEST ?= latest-$(TOMSHLEY_DOCKERS_BUILD_REF)
endif

check_cli = type "$(1)" >/dev/null 2>&1 || { echo "Error: command '$(1)' required but not found. Exiting." ; exit 1 ; }
check_image = make --silent list | grep -w '$(1)' >/dev/null 2>&1 || { echo "Error: the image '$(1)' does not exist in manifest for the platform 'linux/$(ARCH)'. Please check the output of 'make list'. Exiting." ; exit 1 ; }
bake_base_cli := docker buildx bake -f docker-bake.hcl

check-reqs:
	@$(call check_cli,bash)
	@$(call check_cli,git)
	@$(call check_cli,docker)
	@docker info | grep 'buildx:' >/dev/null 2>&1 || { echo "Error: Docker BuildX plugin required but not found. Exiting." ; exit 1 ; }

build-local: check-reqs
	@set -x; $(bake_base_cli) --set '*.platform=linux/$(ARCH)' $(shell make --silent list)

build-load: check-reqs
	@set -x; $(bake_base_cli) --load

build: check-reqs
	@set -x; $(bake_base_cli)

push: check-reqs
	@set -x; $(bake_base_cli) --push
