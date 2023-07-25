#!/usr/bin/env sh
. "${CI_PROJECT_DIR}/scripts/cicd-exports.sh"

cd "${CI_PROJECT_DIR}" || exit

tomshley_release_finish_message="Tomshley Release Version ${TOMSHLEY_BREAKGROUND_BUILD_VERSION}"
export GIT_MERGE_AUTOEDIT=no ; \
git fetch ; \
git checkout main ; \
git merge --no-ff release/$TOMSHLEY_BREAKGROUND_BUILD_VERSION -m "${tomshley_release_finish_message} | main | [skip ci]" ; \
git tag -a $TOMSHLEY_BREAKGROUND_BUILD_VERSION -m "${tomshley_release_finish_message}" ; \
git checkout develop ; \
git merge --no-ff release/$TOMSHLEY_BREAKGROUND_BUILD_VERSION -m "${tomshley_release_finish_message} | develop | [skip ci]"; \
git branch -d release/$TOMSHLEY_BREAKGROUND_BUILD_VERSION ; \
git push origin main ; \
git push origin develop ; \
git push origin --tags ; \
git push origin :release/$TOMSHLEY_BREAKGROUND_BUILD_VERSION ; \
unset GIT_MERGE_AUTOEDIT
