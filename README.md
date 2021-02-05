# Software Engineering Course

## Prerequisites, CI/CD VM
* Allocate Ubuntu VM (20.04)
* Refresh env to the latest packages
  ```
  apt-get update && apt-get upgrade -y
  ```

* Install NodeJS & helper - [talan cli](https://github.com/project-talan/tln-cli)
* Install docker & docker compose
  ```
  tln install docker:docker-compose-1.28.0 && docker -v && docker-compose -v
  ```
