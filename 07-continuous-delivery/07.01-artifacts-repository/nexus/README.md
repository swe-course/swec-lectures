
## Nexus
* Up Nexus instance
  ```
  > cd ~/projects/swe-course/swec-lectures/07-continuous-delivery/07.01-artifacts-repository/nexus
  > ./nexus-up.sh -d
  ```
* Open page in browser **http://\<host-ip-address\>:8081/nexus**
* Login using credentials user/pass **admin**, **password** can be found here ```cat /opt/nexus/nexus-data/admin.password```
* Create new maven2 hosted repository, name: **dbox**
  ![](https://raw.githubusercontent.com/swe-course/swec-content/master/imgs/nexus-maven-repo.png)
