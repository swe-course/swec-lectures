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
  tln install-default docker 
  sudo curl -L "https://github.com/docker/compose/releases/download/1.28.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  docker -v && docker-compose -v
  ```
