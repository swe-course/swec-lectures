## Jenkins
### Install
  ```
  tln install default-jre:default-maven:jenkins
  ```
### Complete setup
* Open page in browser **http://\<host-ip-address\>:8080**
* Complete installation, using provided instructions (Install suggested plugins, use new password)
  ![](https://github.com/swe-course/swec-lectures/raw/master/imgs/jenkins-01.png)
* Modify JAVA_ARGS in /etc/default/jenkins
  ```
  JAVA_ARGS="-Djava.awt.headless=true"
  to
  JAVA_ARGS="-Djava.awt.headless=true -Dhudson.DNSMultiCast.disabled=true"
  ```
  and restart Jenkins
  ```
  service jenkins restart
  ```
* Create access token
  ![](https://github.com/swe-course/swec-lectures/raw/master/imgs/jenkins-13.png)
* Install additional plugins: '**GitHub Pull Request Builder**', '**SonarQube Scanner for Jenkins**', '**Pipeline Utility Steps**', '**HTTP Request Plugin**', '**Pipeline Maven Integration Plugin**'
  ```
  tln install-plugins jenkins --token <your-token> --plugins "ghprb sonar pipeline-utility-steps http_request pipeline-maven"
  ```
### Configure plugins
* Create SonarQube access credentials, goto **Credentials/System/Global credentials (unrestricted)/Add Credentials** and use access token for SonarQube
  ![](https://github.com/swe-course/swec-lectures/raw/master/imgs/jenkins-02.png)
* Configure "SonarQube servers" instance, goto **Manage Jenkins/Configure System**, use **SonarQube** as server name 
  ![](https://github.com/swe-course/swec-lectures/raw/master/imgs/jenkins-03.png)
* Create Github access credentials, goto **Credentials/System/Global credentials (unrestricted)/Add Credentials** and use access token for Github
  ![](https://github.com/swe-course/swec-lectures/raw/master/imgs/jenkins-04.png)
* Configure "GitHub" instance, goto **Manage Jenkins/Configure System**, use **Github** as instance name
  ![](https://github.com/swe-course/swec-lectures/raw/master/imgs/jenkins-05.png)
* Configure "GitHub Pull Request Builder", goto **Manage Jenkins/Configure System**
  ![](https://github.com/swe-course/swec-lectures/raw/master/imgs/jenkins-06.png)

### Configure tools
* Configure "SonarQubeScanner", goto **Manage Jenkins/Global Tool Configuration** and use **SonarQubeScanner** as tool name
  ![](https://github.com/swe-course/swec-lectures/raw/master/imgs/jenkins-07.png)

### Configure new Jenkins job
* Fork application template from parent project ```https://github.com/swe-course/swec-template```
  ![](https://github.com/swe-course/swec-lectures/raw/master/imgs/jenkins-12.png)  
* Create new pipeline, using **swec-template** as name and your fork as Github project
  ![](https://github.com/swe-course/swec-lectures/raw/master/imgs/jenkins-08.png)

* Configure "GitHub Pull Request Builder"
  ![](https://github.com/swe-course/swec-lectures/raw/master/imgs/jenkins-09.png)
* Chech "GitHub hook trigger for GITScm polling" switch
* Configure pipeline
  * Select **Pipeline script from SCM**
  * Select SCM **Git**
  * Set repository url, it should point to your fork
  * Use git repo Refspec (**Advanced** button):
    ```
    +refs/heads/*:refs/remotes/origin/* +refs/pull/*:refs/remotes/origin/pr/*
     ```
  * Add additional branch
    ```
    ${sha1}
    ```
  ![](https://github.com/swe-course/swec-lectures/raw/master/imgs/jenkins-10.png)

* Add environment variables, goto **Manage Jenkins/Configure System**
  ![](https://github.com/swe-course/swec-lectures/raw/master/imgs/jenkins-14.png)

  | Parameter name | Value |
  | --- | --- |
  | SWEC_SONARQUBE_ACCESS_TOKEN | **\<sonar-access-tocker\>** |
  | SWEC_GITHUB_ACCESS_TOKEN | **\<github-access-token\>** |
  | SWEC_NEXUS_HOST | **http://\<host-ip-address\>:8081** |
  | SWEC_NEXUS_REPO | **swec-template** |
  | SWEC_NEXUS_USER | **admin** |
  | SWEC_NEXUS_PASS | **\<nexus-password\>** |


## Gonfigure branch(es)
* Mark master branch as protected at Github repository **Settings**
  ![](https://github.com/swe-course/swec-lectures/raw/master/imgs/github-02.png)





