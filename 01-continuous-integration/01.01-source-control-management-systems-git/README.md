### (1) Configure remote VM as git server
#### Login into remote VM
```
# if you have no SSH key installed
ssh root@<git-host-ip-address>

# if you already have SSH key
ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no root@<git-host-ip-address>
```
#### Configure git user
```
#!/bin/bash

# Create git user
adduser git

# Create folder for git repositories
cd /opt
mkdir git

# Change folder owner
chown git:git git
ls -la
```
### (2) Generate SSH key to be able to access git server in easy and secure way
#### Switch to your local machine
```
#!/bin/bash

# Go to .ssh folder
cd ~/.ssh

# Generate pair of SSH keys, use swec as key name, use empty passphrase
ssh-keygen -t rsa -b 4096 -C "your_email@domain.com" -f ~/.ssh/swec

# Add SSH config file on local machine, use your remote VM ip address as host-ip-address
echo "Host <git-host-ip-address>" > config
echo "  IdentityFile ~/.ssh/swec" >> config
chmod 600 ./config
ll
cat config

# Copy public key to the remote VM
ssh-copy-id -i ~/.ssh/swec git@<git-host-ip-address>

# Test SSH connection
ssh -T git@<git-host-ip-address>
```

### (3) Create bare repository
#### Switch back to the remote VM
```
#!/bin/bash

# Act as git user
su - git

# Create folder for the new git repository
mkdir /opt/git/swec.git

# Initialize bare repository
cd /opt/git/swec.git
git --bare init

ls -la

# exit git session with Ctrl+D
```

### (4) Clone repository
#### Switch back to your local machine
```
#!/bin/bash

# Go to home folder
cd ~

# Create project's home
mkdir projects && cd projects

# Clone repository
git clone git@<git-host-ip-address>:/opt/git/swec.git && cd swec
git config --local user.name "your name"
git config --local user.email "your email"
git config --local --list

# Add new file
touch README.md
git status
git add .
git status
git commit -m"first commit"
git log
git push origin master
```

### (5) Branches
```
#!/bin/bash

# Create new branch
git checkout -b 20.1.0
touch file-20.1.0.txt
git add .
git status
git commit -m"v20.1.0"
git checkout master

# Display all branches
git branch
git branch -av

# Push branch
git checkout 20.1.0
git push origin 20.1.0

# Dislay one more remote branch
git branch -av

# Display bracnhes on origin remote
git ls-remote origin
```

### (6) Submodules
```
#!/bin/bash

git checkout master
git checkout -b submodule

# Add submodule
git submodule add https://github.com/pure-css/pure.git pure-css
git submodule init
git submodule update
cat .gitmodules
cd pure-css
git branch
git branch -av
cd ..
git add .
git commit -m"pure-css submodule"
```

### (7) Merge
```
#!/bin/bash

git checkout master

# Merge first branch
git merge 20.1.0

# Merge second branch
git merge submodule

# :wq - exit vim )

# To see a diamond
git log --graph

# Publish changes
git push origin master
```

### (8) Remotes
```
#!/bin/bash

git remote -v
```

### (9) Stash
```
#!/bin/bash

# add new file into git index
touch file2stash-index
git add .

touch file2stash-workdir

git status

# stach changes
git stash save -u
git stash list

# switch to another branch
git checkout submodule
git stash pop
git add .
git commit -m"commit stashed changes"
```

### (10) Cherry-pick
```
#!/bin/bash

#
git checkout master

#
git checkout -b feature

# create file 1.txt
touch 1.txt
git add .
git commit -m"1.txt"

# create file 2.txt
touch 2.txt
git add .
git commit -m"2.txt"

# create file 3.txt
touch 3.txt
git add .
git commit -m"3.txt"

git log -4
# copy commit hash for "2.txt" <commit-hash>

git checkout master
ls -la
git cherry-pick <commit-hash>
```

### (11) Rebase & squash
```
#!/bin/bash

# create new branch
git checkout -b b2r

# make changes inside b2r branch
touch b2r-1
git add .
git commit -m"b2r-1 commit"

touch b2r-2
git add .
git commit -m"b2r-2 commit"

# switch to master and make changes there
git checkout master
touch b2r.master
git add .
git commit -m"b2r commit in master"

# rebase
git checkout b2r
git rebase -i master

git checkout master
git merge b2r
```

### (12) Subtree
```
#!/bin/bash

# add project remote
git remote add pure-css-upstream https://github.com/pure-css/pure.git

git remote -v

git subtree add --prefix pure-css-subtree pure-css-upstream master --squash
git branch -av
git subtree pull --prefix pure-css-subtree pure-css-upstream master --squash

## edit README.md
#git subtree push --prefix pure-css-subtree pure-css-upstream master
```

### (13) Revert
```
#!/bin/bash

# create and modify additional branch
git checkout -b b2revert
touch revert.txt
git add .
git commit -m"revert.txt"

# modify master branch
git checkout master
touch master.txt
git add .
git commit -m"master.txt"

# merge
git merge b2revert

# exit :wq
git log --graph -4

# revert merge commit
git revert HEAD
#error: commit <SHA1> is a merge but no -m option was given.

# revert with parent from master
git revert HEAD -m 1
git log --graph -4

# revert revert
git revert HEAD
git log --graph -4
```

### (14) Reset
```
#!/bin/bash

# mixed
# remove from index
touch file2reset.txt
git status
git add .
git status
git reset HEAD -- .
git status

# soft
git add .
git commit -m"file2reset"
git reset --soft HEAD^1
git status

# hard
git reset --hard HEAD^1
git status

# ^ vs ~
# http://www.paulboxley.com/blog/2011/06/git-caret-and-tilde
```

### (15) Tags & detached-head
```
#!/bin/bash

# create annotated tag
git tag -a v20.1.0 -m "my-project 20.1.0 GA"
git show v20.1.0

# tag old commit
git checkout -b rc1 HEAD~2
git tag -a v20.1.0-rc1 -m "20.1.0-rc1"

git checkout master
git branch -d rc1
git tag

# share tags
git push origin v20.1.0

# fetch
git fetch origin --tags

# checkout tags
git checkout v20.1.0-rc1
git checkout -b rc1

# delete
git tag -d v20.1.0-rc1
git tag --list
```

### (16) Orphan
```
#!/bin/bash

# create orphan branch
git checkout --orphan project2
git rm -rf .

echo "#Title of Project2 branch" > README.md
git add .
git commit -a -m "Initial Commit for Project2"

git log
git branch -av
```

### (17) Hooks

### (18) Refspecs

### (19) sparse-checkout

