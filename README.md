# Tomshley LLC Breakground Provisioning
This repository is the seed for the infrastructure and gitops tenancy of tomshley

[![wakatime](https://wakatime.com/badge/user/9935bae7-7c1d-4843-8d0e-0fb7fa86272f/project/4f113864-46a6-4b45-83c6-caa12f856701.svg)](https://wakatime.com/badge/user/9935bae7-7c1d-4843-8d0e-0fb7fa86272f/project/4f113864-46a6-4b45-83c6-caa12f856701)

```shell
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

