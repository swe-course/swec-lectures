
## Nexus
* Up Nexus instance
  ```
  tln up nexus
  ```
* Open page in browser **http://\<host-ip-address\>:8081**
* Login using credentials **user** - **admin**, **password** can be found here ```cat /opt/nexus/nexus-data/admin.password```
* Create new **maven2(hosted)** **mixed** type repository, using **swec-template** as a name
  ![](https://github.com/swe-course/swec-lectures/raw/master/imgs/nexus-01.png)
