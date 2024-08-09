# Tomshley LLC Breakground Provisioning
This repository is the seed for the infrastructure and gitops tenancy of tomshley

#### Step 0 - setup your repository from github
```shell
mkdir breakground-provisioning
cd breakground-provisioning
git init

git remote add origin git@gitlab.com:<mycompanyname>/breakground-provisioning.git

git remote add public-upstream-fork-sync https://github.com/tomshley/breakground-provisioning.git

git remote -v
```

```shell
git pull public-upstream-fork-sync
git branch --track public-upstream-fork-sync-main public-upstream-fork-sync/main
git checkout public-upstream-fork-sync-main
git lfs pull public-upstream-fork-sync
git checkout -b main-bootstrap
cd terraform/backends/local
rm -rf .terraform* .tfstate.plan*

```

Edit you repo config
```terraform
module "provisioning-backends-local-gl" {
  providers = {
    gitlab = gitlab
    github = github
  }
  source                  = "../../modules/provisioning-backends-local-gl"
  github_mirror_token     = var.github_mirror_token
  github_owner_group_path = var.github_owner_org
  github_projects_with_parent = [
    (["breakground-provisioning", "<mycompanyname>", "<mycompanyname>", "private"]),
  ]
  gitlab_projects_with_parent = [
    (["breakground-provisioning", "<mycompanyname>", "<group_id>", "private"]),
  ]
  gitlab_project_mirrors = [
    (["breakground-provisioning", ""])
  ]
}
```
```shell
cd terraform/backends/local

make plan

make apply

git add -f .terraform.lock.hcl .tfstate.plan* .tfstate.plan.json main.tf

git commit -m "Initial breakground provision" 

git checkout --track origin/main

git fetch

git checkout main

git merge --allow-unrelated-histories main-bootstrap 


```



git push -u origin main-bootstrap
```

#### Step 1 - create an access token for gitlab and github
- https://github.com/settings/tokens
- https://gitlab.com/-/profile/personal_access_tokens or https://gitlab.com/groups/tomshley/-/settings/access_tokens

#### Step 2 - copy the owner group in gitlab

![readme-gitlab-group-id.png](readme-gitlab-group-id.png)

#### Step 3 - create a .tfstate.env file in local and remote backends

Example:
```dotenv
GL_PROJECT_ID=8008
TF_PROJECT_ID=${GL_PROJECT_ID}
GH_USERNAME=yourusername
GH_PASSWORD=ghp_LKiusydhafllj786t8o7iuhKKJKK
GH_OWNER_ORG=yourorgname
GH_MIRROR_TOKEN=yourusername:ghp_LKiusydhafllj786t8o7iuhKKJKKLUKGDSFas7t78tiglkjHKK
GL_USERNAME=yourusername
GL_PASSWORD=glsadfpat-assadfsasdgg
TF_USERNAME=${GL_USERNAME}
TF_PASSWORD=${GL_PASSWORD}
TF_HOST=https://git.rajant.health
TF_ADDRESS=${TF_HOST}/api/v4/projects/${TF_PROJECT_ID}/terraform/state/tware-dayzero-provisioning
ARTIFACTORY_ACCESS_TOKEN=asdtqw4t3hbsgdbew54t35t

```

```shell
brew install jq

brew install opentofu

cd ./cd terraform/backends/local/

# to initialize terraform. this will initialize with a local backend to bootstrap gitlab remote
make init

# use the terraform state to plan a new provisioning run
make plan

# apply the changes and save the state
make apply
```

As a note, this process will setup the initial breakground repository (project) and provision a docker container registry

### Setup the local docker registry profile
```shell
docker buildx create --name mybuilder --use --bootstrap

docker login registry.gitlab.com

# note: use an access token
# Username: sgoggles
# Password: #########
# Login Succeeded
```

### Setup the CI/CD Prerequisites
This file is needed to run Terraform init and plan
![.tfstate.env](readme-tfstate-example.png)


## License
Copyright 2023 Tomshley LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

