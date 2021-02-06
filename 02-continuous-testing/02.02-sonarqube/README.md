
## SonarQube
* Up SonarQube instance
  ```
  tln install sonarqube -- --db-root-pass "password" --db-pass "password"
  ```
* Open page in browser **http://\<host-ip-address\>:9000**
* Login using credentials user/pass **admin/admin**
* Skip tutorial

* Install "Github" plugin
  ![](https://github.com/swe-course/swec-lectures/raw/master/imgs/sonar-01.png)

* Update **SonarJava** plugin to the latest available version
  ![](https://github.com/swe-course/swec-lectures/raw/master/imgs/sonar-03.png)

*  **Restart** Sonar, using hint at the top of the page

* Generate access token
  ![](https://github.com/swe-course/swec-lectures/raw/master/imgs/sonar-02.png)

* Save token for future use
