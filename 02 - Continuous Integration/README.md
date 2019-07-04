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

# Generate pair of SSH keys, use sec as key name, use empty passphrase
ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f ~/.ssh/swec

# Add SSH config file on local machine, use your remote VM ip address as host-ip-address
echo "Host <git-host-ip-address>" > config
echo "  IdentityFile ~/.ssh/swec" >> config

# Copy public key to the remote VM
ssh-copy-id -i ~/.ssh/swec git@<git-host-ip-address>
```
