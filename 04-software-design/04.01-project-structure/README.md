## Prerequisites
* Install [talan cli](https://github.com/project-talan/tln-cli)
* Install Jenkins, Docker
  ```
  tln install java:maven:jenkins && tln install-default docker
  ```
* Create projects' root
  ```
  mkdir projects && cd projects && tln config --terse
  ```

## Multi-repo
* Prepare working directory
  ```
  mkdir multi-repo && cd multi-repo && tln config --terse
  ```
* Create two projects: one for frontend and one for backend
  ```
  mkdir frontend && cd frontend && git init && npx create-react-app . && tln config --terse --depend node-17.0.0 && tln install --depends
  ```
  ```
  git config --local user.name <your_name> && git config --local user.email <your_email>
  ```
  ```
  git add -A && git commit -m "v21.10.1" && git tag v21.10.1
  ```
  ```
  cd ..
  ```
  ```
  mkdir backend && cd backend && git init && npm init && tln config --terse --depend node-16.12.0 && tln install --depends
  ```
  ```
  git config --local user.name <your_name> && git config --local user.email <your_email>
  ```
  ```
  git add -A && git commit -m "v21.11.0" && git tag v21.11.0
  ```
  
* Create repository for whole solution
  ```
  cd ..
  ```
  ```
  mkdir saas && cd saas && git init && tln config --terse --depend kubectl-1.22.2 && tln install --depends
  ```
  ```
  git config --local user.name <your_name> && git config --local user.email <your_email>
  ```
  ```
  git add -A && git commit -m "init structure"
  ```
  ```
  git remote add frontend ../frontend && git remote add backend ../backend && git remote -v
  ```
  ```
  git subtree add --prefix=frontend/admin frontend v21.10.1
  ```
  ```
  git subtree add --prefix=backend/admin backend v21.11.0
  ```
  ```
  git log --graph --oneline
  ```

## Mono-repo
* Prepare working directory
  ```
  mkdir mmono-repo && cd mono-repo && git init && tln config --terse
  ```
  ```
  git config --local user.name <your_name> && git config --local user.email <your_email>
  ```
* Create **version** file
  ```
  echo 21.11.0-dev > version
  ```
* Create **.context** file
  ```
  echo ci > .context
  ```
* Create env files
  ```
  touch .env
  touch .env.template
  ```
* Edit **.tln** (just copy-paste content below)
  ```
  module.exports = {
    options: async (tln, args) => {},
    env: async (tln, env) => {

    },
    dotenvs: async (tln) => [],
    inherits: async (tln) => [],
    depends: async (tln) => [],
    steps: async (tln) => [],
    components: async (tln) => []
  }
  ```
* Create **Jenkinsfile** file with next content
  ```
  node {
  }
  ```
* Create **.gitignore** file with next content
  ```
  echo ".env
  .context" > .gitignore
  ```
* Commit initial configuration
  ```
  git add -A && git commit -m "Initial configuration"
  ```
