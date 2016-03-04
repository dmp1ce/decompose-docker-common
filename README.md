[![Build Status](https://travis-ci.org/dmp1ce/decompose-docker-common.svg?branch=master)](https://travis-ci.org/dmp1ce/decompose-docker-common)
# decompose-docker-common
Common code for decompose environment that use Docker

## Requirements

- [decompose](https://github.com/dmp1ce/decompose)
- [Docker](https://www.docker.com/)
- [Docker Compose](https://www.docker.com/docker-compose)

## How to use

Include this library and source `elements` and `processes` files your main decompose environment.

### Example

First add lib as a submodule to your environment:
``` bash
$ cd .decompose/environment
$ git submodule add https://github.com/dmp1ce/decompose-docker-common.git lib/docker
```

Then make your `processes` file look like this:
``` bash
$ cat processes
# Include common processes
source $(_decompose-project-root)/.decompose/environment/lib/docker/processes
DECOMPOSE_PROCESSES=( "${DECOMPOSE_DOCKER_PROCESSES[@]}" )
```

## Elements

- `PRODUCTION` : Docker Compose will for container recreation if `PRODUCTION` variable is set.

## Processes

- `remove-untagged-docker-images` : Removes all Docker images that are not tagged. Used to clean up most of the unused images.

### Other functions

These functions can be used inside your custom processes.

- `_decompose-process-docker-build` : Builds Docker Compose project.
- `_decompose-process-docker-up` : Starts Docker Compose project.
