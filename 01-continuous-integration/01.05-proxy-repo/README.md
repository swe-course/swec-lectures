
### Create two test repositories
```
tln config --terse && git init service1 && git init service2
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
cd .. && git init project.io && cd project.io && git config --local user.name "user" && git config --local user.email "user@email.com"
```
