
## Nexus
* Up Nexus instance
  ```
  > cd ~/projects/swe-course/swec-lectures/07-continuous-delivery/07.01-artifacts-repository/nexus
  > ./nexus-up.sh -d
  ```
* Access point **http://\<host-ip-address\>:8081/nexus**, user/pass **admin/admin123**
* Create new maven2 hosted repository, name: **saas-template**
  ![](https://raw.githubusercontent.com/swe-course/swec-content/master/imgs/nexus-maven-repo.png)
