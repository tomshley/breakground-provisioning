#!/usr/bin/env sh
. "${CI_PROJECT_DIR}/scripts/cicd-exports.sh"

cd "${CI_PROJECT_DIR}" || exit

# set the -sbt- build to release not, snapshot
tomshley_project_version_src="${CI_PROJECT_DIR}/VERSION"

git fetch
git checkout -b "release/${TOMSHLEY_BREAKGROUND_BUILD_VERSION_NEXT}" develop

echo "${TOMSHLEY_BREAKGROUND_BUILD_VERSION_NEXT}" > "${tomshley_project_version_src}"

git add "${tomshley_project_version_src}"

git commit -m "$(git log --format='%B' -n 1) | bumping version to ${TOMSHLEY_BREAKGROUND_BUILD_VERSION_NEXT}"
