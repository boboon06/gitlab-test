# Gitlab Test
## Dependencies 
This repo requires:
* GitLab [Container Registry](https://docs.gitlab.com/ee/user/packages/container_registry/) to be enabled to distribute the Docker containers around runners, and to allow debugging of the build output.
* GitLab runners setup to run [Docker-in-Docker](https://docs.gitlab.com/ee/ci/docker/using_docker_build.html#use-the-docker-executor-with-the-docker-image-docker-in-docker)

## Running the pipeline
You need to run the manual `cmake-container-build` step before the `simulator-build` step will work, this step will download and build CMake from source code into a docker container so it will take some time.
All other steps will be triggered automatically from pushed commits.