## Prerequisites
* Prepare working directory
  ```
  cd ~ && mkdir projects && cd projects && tln config --terse && mkdir docker-playground && cd docker-playground && tln config --terse
  ```
* Edit .tln.conf file 
  ```
  module.exports = {
    options: async (tln, args) => {},
    env: async (tln, env) => {

    },
    dotenvs: async (tln) => [],
    inherits: async (tln) => [],
    depends: async (tln) => ['docker-compose-1.29.2'],
    steps: async (tln) => [],
    components: async (tln) => []
  }
  ```
* Install necessary components
  ```
  tln install-default@docker && tln install --depends
  tln shell
  docker -v && docker-compose -v
  ```

## Docker
* Check python 2.x
  ```
  python --version
  ```
* Run docker with Python 2.x
  ```
  docker run -it python:2 bash
  python --version
  python
  ```
* Exit from Python and docker container
  ```
  ^d
  ^d
  ```
* Run docker container in detached mode
  ```
  docker run -d -p 80:80 nginx
  ```
* Check in browser http://<ip>
* Get list of containers
  ```
  docker ps -a
  ```
* Get list of images
  ```
  docker images
  ```

## Docker compose
