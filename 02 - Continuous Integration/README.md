### (1) Configure remote VM as git server
#### Login into remote VM
```
ssh root@<git-host-ip-address>
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

# Copy public key to the remote VM
ssh-copy-id -i ~/.ssh/swec git@<git-host-ip-address>
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
git clone git@<git-host-ip-address>:/opt/git/swec.git
cd swec
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
git checkout -b 18.8.0
touch file-18.8.0.txt
git add .
git status
git commit -m"v18.8.0"
git checkout master

# Display all branches
git branch
git branch -av

# Push branch
git checkout 18.8.0
git push origin 18.8.0

# View one more remote branch
git branch -av
```

### (5) Submodules
```
#!/bin/bash

git checkout master
git checkout -b submodule

# Add submodule
git submodule add https://github.com/pure-css/pure.git pure-css
git submodule init
git submodule update
cd pure-css
git branch
git branch -av
cd ..
git add .
git commit -m"pure-css submodule"
```
