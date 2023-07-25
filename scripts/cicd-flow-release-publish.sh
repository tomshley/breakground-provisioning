#!/usr/bin/env sh

cd "${CI_PROJECT_DIR}" || exit

git fetch
git checkout "release/${$TOMSHLEY_BREAKGROUND_BUILD_VERSION}"
git pull --rebase origin "release/${$TOMSHLEY_BREAKGROUND_BUILD_VERSION}"
git push origin "release/${$TOMSHLEY_BREAKGROUND_BUILD_VERSION}"
