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
  ``]
* Install necessary components
  ```
  tln install-default@docker && tln install --depends
  tln shell
  docker -v && docker-compose -v
  ```

## Docker


## Docker compose
