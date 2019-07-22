
## Nexus
* Up Nexus instance
  ```
  cd ~/projects/swe-course/swec-lectures/07-continuous-delivery/07.01-artifacts-repository/nexus
  ./nexus-up.sh -d
  ```
* Open page in browser **http://\<host-ip-address\>:8081**
* Login using credentials **user** - **admin**, **password** can be found here ```cat /opt/nexus/nexus-data/admin.password```
* Create new maven2 **mixed** type repository, using **dbox** as a name
  ![](https://github.com/swe-course/swec-lectures/raw/master/imgs/nexus-01.png)
