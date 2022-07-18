
### Create two test repositories
```
tln config --terse --inherit git && git init service1 && git init service2
```

### Publish two vesions for two projects
```
cd service1 && git config --local user.name "user" && git config --local user.email "user@email.com" && touch README.md && git add . && git commit -m"v22.6.1" && git tag -a v22.6.1 -m "io.project.service1:22.6.1"
```

```
cd ../service2 && git config --local user.name "user" && git config --local user.email "user@email.com" && touch README.md && git add . && git commit -m"v22.7.0" && git tag -a v22.7.0 -m "io.project.service2:22.7.0"
```

### Configure proxy repo
```
cd .. && git init project.io && cd project.io && git config --local user.name "user" && git config --local user.email "user@email.com" && touch README.md && git add . && git commit -m"Initial structure"
```
#### Add sibtrees 
```
tln subtree-add -- --prefix services/service1 --subtree ../service1 --ref v22.6.1 --squash
```
```
tln subtree-ls
```
```
git add . && git commit -m"feat: pull service1:22.6.1"
```
```
tln subtree-add -- --prefix services/service2 --subtree ../service2 --ref v22.7.0 --squash && git add . && git commit -m"feat: pull service2:22.7.0"
```
```
tln subtree-ls
```
#### Create project.io release
```
mkdir infr && touch infr/backend.tf && git add . && git commit -m"v22.8.0" && git tag -a v22.8.0 -m "io.project:22.8.0"
```

### Create new service1 version
```
cd ../service1 && touch version && git add . && git commit -m"v22.8.0" && git tag -a v22.8.0 -m "io.project.service1:22.8.0"
```

### Pull new service1 version
```
cd ../project.io && tln subtree-pull -- --prefix services/service1 --ref v22.8.0 --squash && git add . && git commit -m"v22.8.1" && git tag -a v22.8.1 -m "io.project:22.8.1"
```
```
tln subtree-ls
```

