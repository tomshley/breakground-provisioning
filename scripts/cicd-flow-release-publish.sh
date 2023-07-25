#!/usr/bin/env sh
. "${CI_PROJECT_DIR}/scripts/cicd-exports.sh"

cd "${CI_PROJECT_DIR}" || exit

git fetch
git checkout "release/${$TOMSHLEY_BREAKGROUND_BUILD_VERSION}"
git pull --rebase origin "release/${$TOMSHLEY_BREAKGROUND_BUILD_VERSION}"
git push origin "release/${$TOMSHLEY_BREAKGROUND_BUILD_VERSION}"
