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
* Create index.html with next content
  ```
  touch index.html
  nano index.html
  ```
  
  ```
  <html><body><h1>Hi from SEC</h1></body></html>
  ```
* Create Dockerfile with next content
  ```
  touch Dockerfile
  nano Dockerfile
  ```
  
  ```
  FROM nginx
  COPY ./index.html /usr/share/nginx/html
  ```
* Build Dockerfile
  ```
  docker build -t sec:21.10.0 .
  docker images
  ```
  
* Run image
  ```
  docker run --rm -it -p 80:80 sec:21.10.0
  ```
  
* Run base nginx image using volume
  ```
  docker run --rm -it -p 80:80 -v /root/projects/docker-playground:/usr/share/nginx/html nginx
  ```
  
  

## Docker compose
* Create Dockerfile with next content
  ```
  touch docker-compose.yml
  nano docker-compose.yml
  ```
  
  ```
  version: '3'

  services:
    sonarqube:
      image: sonarqube:6.7.7-community
      ports:
        - 9000:9000
        - 9002:9002
      networks:
        - sonarnet
      environment:
        - SONARQUBE_JDBC_URL=jdbc:mysql://sonarqube_db:3306/sonar?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance&useSSL=false
        - SONARQUBE_JDBC_USERNAME=sonar
        - SONARQUBE_JDBC_PASSWORD=password
      depends_on:
        - sonarqube_db
      links:
        - sonarqube_db
    sonarqube_db:
      image: mysql:5.7
      command: --max_allowed_packet=16777216
      networks:
        - sonarnet
      volumes:
        - /opt/sonarqube/db:/var/lib/mysql
      environment:
        - MYSQL_DATABASE=sonar
        - MYSQL_ROOT_PASSWORD=password
        - MYSQL_USER=sonar
        - MYSQL_PASSWORD=password

  networks:
    sonarnet:
      driver: bridge
  ```

* Run cluster
  ```
  docker-compose up
  ```  
  
