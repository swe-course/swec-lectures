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
  mkdir mono-repo && cd mono-repo && git init && tln config --terse
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
  echo "const path = require('path');
  const fs = require('fs');

  module.exports = {
    options: async (tln, args) => {
      const devDomain = 'ctimes.cloud';
      const prodDomain = 'ctimes.cloud';

      let envType = 'dev01';
      let domain = `${envType}.${devDomain}`;
      let cluster = 'dev';
      let namespace = envType;
      //
      const context = path.join(__dirname, '.context');
      if (fs.existsSync(context)) {
        envType = fs.readFileSync(context, 'utf8').trim();

        // map environment type to the cluster and namespace
        ({ domain, cluster, namespace } = ({
          ci:     { domain: `ci.${devDomain}`,    cluster: 'dev',   namespace: 'ci' },
          dev01:  { domain: `dev01.${devDomain}`, cluster: 'dev',   namespace: 'dev01' },
          qa01:   { domain: `qa01.${devDomain}`,  cluster: 'dev',   namespace: 'qa01' },
          uat01:  { domain: `uat01.${devDomain}`, cluster: 'dev',   namespace: 'uat01' },
          prod:   { domain: prodDomain,           cluster: 'prod',  namespace: 'prod' }
        })[envType]);
      }
      args
        .prefix('TLN_MONO_REPO')
        .option('domain', { describe: 'Domain to deploy to', default: domain, type: 'string' })
        .option('environment', { describe: 'Environment id', default: envType, type: 'string' })
        .option('cluster', { describe: 'k8s cluster', default: cluster, type: 'string' })
        .option('namespace', { describe: 'k8s namespace', default: namespace, type: 'string' })
        .option('kube-config', { describe: 'k8s configuration file', default: `.kube.config.${cluster}`, type: 'string' })
        .option('registry', { describe: 'Container registry', default: `registry.digitalocean.com/projects-cr`, type: 'string' })
      ;
    },
    env: async (tln, env) => {
      env.TLN_UID = 'cloud.ctimes';
      env.TLN_VERSION = fs.readFileSync(path.join(__dirname, 'version'), 'utf8').trim();
      env.KUBECONFIG = path.join(__dirname, env.TLN_MONO_REPO_KUBE_CONFIG);

      env.TLN_DOCKER_REGISTRY = env.TLN_MONO_REPO_REGISTRY;
      const crToken = path.join(__dirname, 'secrets', 'cr-token');
      if (fs.existsSync(crToken)) {
        env.TLN_DOCKER_REGISTRY_TOKEN = fs.readFileSync(crToken, 'utf8').trim();
      } else {
        tln.logger.warn('Container registry token was not configured, please see README.md for more details');
      }
    },
    dotenvs: async (tln) => ['.env'],
    inherits: async (tln) => [],
    depends: async (tln) => ['kubectl-1.20.2', 'terraform-1.0.11', 'helm-3.7.1'],
    steps: async (tln) => [
      {
        id: 'prereq', builder: async (tln, script) => script.set([`
  ${tln.call('tln install --depends')}

  ${tln.call('tln install frontend/portal --depends')}
  ${tln.call('tln init frontend/portal')}

  ${tln.call('tln install   backend/api --depends')}
  ${tln.call('tln init backend/api')}

  ${tln.call('tln install infr --depends')}
  `     ])
      },
      {
        id: 'build', builder: async (tln, script) => script.set([`
  ${tln.call('tln docker-build:docker-tag:docker-push frontend/portal')}
  ${tln.call('tln docker-build:docker-tag:docker-push backend/api')}
  `     ])
      },
      //--------------------------------------------------------------------------
      { id: 'create-secrets', filter: 'linux', builder: async (tln, script) => {
          const crt = path.join(__dirname, 'secrets', 'ctimes.cloud.crt');
          const key = path.join(__dirname, 'secrets', 'ctimes.cloud.key');    
          const config = path.join(__dirname, 'secrets', 'config.json');

          const secrets = path.join(__dirname, 'secrets', 'values.yaml');

          script.set([`
  echo "tlsCertificate: |" > ${secrets} && cat ${crt} | sed 's/^/  /' >> ${secrets} && \\
  echo "tlsKey: |" >> ${secrets} && cat ${key} | sed 's/^/  /' >> ${secrets} && \\
  echo "dockerSecret: |" >> ${secrets} && cat ${config} | sed 's/^/  /' >> ${secrets}
          `]);
        }
      },
      {
        id: 'status', builder: async (tln, script) => {
          script.set([`
  kubectl get all -n ${script.env.TLN_MONO_REPO_NAMESPACE}
          `]);
        }
      },
      {
        id: 'deploy', builder: async (tln, script) => {
          script.set([`
  helm upgrade --install mono-repo-${script.env.TLN_MONO_REPO_NAMESPACE} ${path.join(__dirname, 'app')} \\
  --set domain=${script.env.TLN_MONO_REPO_DOMAIN} \\
  --set namespace=${script.env.TLN_MONO_REPO_NAMESPACE} \\
  --set atlsNodeVersion=${script.env.TLN_VERSION} \\
  --set registry.auth="${script.env.TLN_DOCKER_REGISTRY_TOKEN}"
          `]);
        }
      },
      {
        id: 'undeploy', builder: async (tln, script) => {
          script.set([`
  helm uninstall mono-repo-${script.env.TLN_MONO_REPO_NAMESPACE}
          `]);
        }
      }
    ],
    components: async (tln) => []
  }
  ```
* Create **Jenkinsfile** file with next content
  ```
  echo "node {
  }" > Jenkinsfile
  ```
* Create **.gitignore** file with next content
  ```
  echo ".env
  secrets
  .kube.config*
  .context" > .gitignore
  ```
* Commit initial configuration
  ```
  git add -A && git commit -m "Initial configuration"
  ```
* Add frontend service
  ```
  tln subtree-add -- --prefix frontend/portal --subtree https://github.com/project-talan/tln-react.git --ref v21.8.0 --squash
  git add -A && git commit -m"frontend"
  ```
* Add backend service
  ```
  tln subtree-add -- --prefix backend/api --subtree https://github.com/project-talan/tln-nodejs --ref v21.3.0 --squash
  git add -A && git commit -m"backend"
  ```
* Add configs
  ```
  echo "module.exports = {
    options: async (tln, args) => {},
    env: async (tln, env) => {
      env.TLN_UID = [env.TLN_UID, env.TLN_COMPONENT_SRC_ID].join('.');

    },
    dotenvs: async (tln) => [],
    inherits: async (tln) => [],
    depends: async (tln) => [],
    steps: async (tln) => [],
    components: async (tln) => []
  }" > frontend/.tln.conf
  echo "module.exports = {
    options: async (tln, args) => {},
    env: async (tln, env) => {
      env.TLN_UID = [env.TLN_UID, env.TLN_COMPONENT_SRC_ID].join('.');

    },
    dotenvs: async (tln) => [],
    inherits: async (tln) => [],
    depends: async (tln) => [],
    steps: async (tln) => [],
    components: async (tln) => []
  }" > backend/.tln.conf
  ```
* Build, tag & push docker images
  ```
  tln build
  ```
* Create Helm chart
  ```
  tln exec -c "helm create app"
  ```






