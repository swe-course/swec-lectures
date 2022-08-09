## SaaS skeleton infrastructure & deployment
### Login to your dev box
### Install prerequisites
  ```
  sudo apt-get update && sudo apt-get upgrade -y &&
  sudo apt-get install mc -y &&
  sudo curl -fsSL https://get.docker.com | bash &&
  curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh &&
  sudo bash nodesource_setup.sh &&
  sudo apt-get install nodejs -y && node -v &&
  npm i -g tln-cli@1.61.0 && tln --version &&
  cd ~ && mkdir projects && cd projects && tln config --terse && git clone https://github.com/swe-course/saas-skeleton.git
  
  ```
### Run Midnight Commander
  ```
  mc  
  ```
### Go to 'saas-skeleton' folder, check repository structure
  ```
  cd saas-skeleton
  ```

### Install components necessary components
  ```
  tln prereq-app && tln install ii/do:app --depends && tln init-app
  ```

### Go to 'ii' folder
  * Prepare .env file and update env variables
  ```
  cp .env.template .env  
  ```
  ```
  TF_VAR_project_name=tln-clouds
  TF_VAR_ii_name=<your initials>
  TF_VAR_env_name=ci
  TF_VAR_tenant_name=petramco
  ```
  * Change TLN_INFRASTRUCTURE_INSTANCE value from 'dev' to 'your initials' were used for TF_VAR_ii_name (.tln.conf ln. 30)

### Go to 'do' folder
  * Prepare .env file and update env variables
  ```
  cp .env.template .env  
  ```
  ```
  DIGITALOCEAN_TOKEN=<token>

  TF_VAR_do_region=fra1
  TF_VAR_do_k8s_version=1.23.9-do.0
  TF_VAR_do_k8s_nodes_min=1
  TF_VAR_do_k8s_nodes_max=1
  TF_VAR_do_k8s_nodes_size=s-2vcpu-2gb
  ```
### Go to repository home
  ```
  cd ../..
  ```
  * Construct Infrastructure Instance
  ```
  tln construct-infr
  ```
  * Update version inside **version** file
  ```
  22.8.0-drop.<your initials>
  ```
  * Wait until public IP (**EXTERNAL-IP**) will be allocated and open it in browser, exit from waiting loop **ctrl + c**
  * Create docker configs and will with auth record
  ```
  mkdir ~/.docker && touch ~/.docker/config.json && touch app/docker-config.json
  ```
  * Package application: build docker images and push them into registry
  ```
  tln package-app
  ```
  * Deploy application
  ```
  tln deploy-app
  ```
  * Run shell
  ```
  tln shell ii/do
  ```
  * Connect to the k8s cluster
  ```
  kubectl get all -n ci
  ```
  * Exit shell **ctrl + d**
  * Undeploy application
  ```
  tln undeploy-app
  ```
  * Delete manually Load Balancer
  * Deconstruct Infrastructure Instance
  ```
  tln deconstruct-infr
  ```
