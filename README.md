# Tomshley LLC Breakground Provisioning
### Setup the local docker registry profile
```shell
docker buildx create --name mybuilder --use --bootstrap

docker login registry.gitlab.com

# note: use an access token
# Username: sgoggles
# Password: #########
# Login Succeeded
```

## License
This repository is the seed for the infrastructure and gitops tenancy of tomshley

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

