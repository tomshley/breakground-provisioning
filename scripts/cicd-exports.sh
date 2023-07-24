#!/usr/bin/env sh

export DOCKERS_LOCAL_ROOT="${CI_PROJECT_DIR}/dockers"
export TF_BACKENDS_LOCAL_ROOT="${CI_PROJECT_DIR}/terraform/backends/local"
export TF_BACKENDS_REMOTE_ROOT="${CI_PROJECT_DIR}/terraform/backends/remote"
export TF_STATE_NAME=tomshley-breakground-provisioning
export TOMSHLEY_BREAKGROUND_BUILD_VERSION=$(cat ${CI_PROJECT_DIR}/VERSION)
export TOMSHLEY_BREAKGROUND_BUILD_VERSION_NEXT=$(echo $TWARE_BUILD_VERSION | awk 'BEGIN { FS="." } { $3++;  if ($3 > 99) { $3=0; $2++; if ($2 > 99) { $2=0; $1++ } } } { printf "v%d.%d.%d\n", $1, $2, $3 }')
export TOMSHLEY_BREAKGROUND_RELEASE="false"
export TOMSHLEY_BREAKGROUND_BUILD_VERSION_NEXT="${TOMSHLEY_BREAKGROUND_BUILD_VERSION_NEXT}"
