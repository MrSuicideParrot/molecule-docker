# molecule-docker
![GitHub last commit](https://img.shields.io/github/last-commit/mrsuicideparrot/molecule-docker?style=for-the-badge)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/mrsuicideparrot/molecule-docker/test-container?label=test%20container&style=for-the-badge)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/mrsuicideparrot/molecule-docker/build-container?label=build%20container&style=for-the-badge)
[![renovate](https://img.shields.io/badge/renovate-enabled-brightgreen.svg?style=for-the-badge)](https://renovatebot.com)

A dockerized version of Ansible Molecule with docker as the provision driver.

This image is automatically compiled everytime there is a new release of [ansible](https://pypi.org/project/ansible/),  [molecule](https://pypi.org/project/molecule/) or [molecule-docker](https://pypi.org/project/molecule/). To check which version the container is using, see the [requirements.txt](requirements.txt).
Currently, this image supports `amd64` and `aarch64`.

## How to use it

### Standalone

You can use this image to test roles with molecule on your computer using docker.

```
docker run --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock -v $PWD:/ansible ghcr.io/mrsuicideparrot/molecule-docker:latest --help
```

### Drone.io

An example of a pipeline using this image to perform a molecule test on an ansible role.

```yaml
kind: pipeline
name: default

steps:
- name: molecule
  image: ghcr.io/mrsuicideparrot/molecule-docker:latest
  pull: true
  privileged: true
  volumes:
  - name: docker-socket
    path: /var/run/docker.sock
  commands:
  - molecule test`

volumes:
- name: docker-socket
  host:
    path: /var/run/docker.sock
```

### Gitlab
You can use this image on Gitlab by creating the following `.gitlab-ci.yml`.

```yaml
---
image: ghcr.io/mrsuicideparrot/molecule-docker:latest

services:
  - docker:dind

molecule:
  stage: test
  script:
    - cd roles/testrole && molecule test
```



