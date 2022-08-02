## SaaS skeleton infrastructure & deplo
### Install prerequisites
  ```
  sudo apt-get update && sudo apt-get upgrade -y &&
  sudo apt-get install mc -y &&
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
### Go to saas-skeleton folder, check repository structure

### Go to ii folder
#### Install components necessary components
  ```
  tln install --depends
  ```
#### Prepare .env file and update env variables
  ```
  cp .env.template .env  
  ```
  ```
  TF_VAR_project_name=tln-clouds
  TF_VAR_ii_name=<your initials>
  TF_VAR_env_name=ci
  TF_VAR_tenant_name=petramco
  ```
### Go to do folder
#### Install components necessary components
  ```
  tln install --depends
  ```
#### Prepare .env file and update env variables
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
### Construct Infrastructure Instance
  ```
  tln construct ii/do
  ```
