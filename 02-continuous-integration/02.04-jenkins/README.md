## Jenkins
### Install
  ```
  tln install default-jre:maven:jenkins
  ```
### Complete setup
* Open page in browser **http://\<host-ip-address\>:8080**
* Complete installation, using provided instructions (Install suggested plugins, use new password)
![](https://github.com/swe-course/swec-lectures/raw/master/imgs/jenkins-01.png)
* Install additional plugins
  ```
  cd ~/projects/swe-course/swec-lectures/02-continuous-integration/02.04-jenkins
  ./install-plugins.sh <jenkins-password>
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
* Create new pipeline, using **swec-template** as name and your fork as Github project
  ![](https://github.com/swe-course/swec-lectures/raw/master/imgs/jenkins-08.png)


### Troubleshooting
* Apply fix(es) for **"ALPN callback dropped: SPDY and HTTP/2 are disabled. Is alpn-boot on the boot class path?"**
  * Check your Java version 
    ```bash
    > java -version
    ```
    
    > openjdk version "1.8.0_191"
    > OpenJDK Runtime Environment (build 1.8.0_191-8u191-b12-0ubuntu0.16.04.1-b12)
    > OpenJDK 64-Bit Server VM (build 25.191-b12, mixed mode)
    
  * Find corresponding alpn boot library
  
    ```
    https://www.eclipse.org/jetty/documentation/9.4.x/alpn-chapter.html#alpn-versions
    ```
    | OpenJDK version | ALPN version |
    | --- | --- |
    | 1.8.0u191 | 8.1.13.v20181017 |
    
  * Copy link to the corresponding ALPN jar from 'ALPN version' folder
    ```
    http://central.maven.org/maven2/org/mortbay/jetty/alpn/alpn-boot/
    ```
    > http://central.maven.org/maven2/org/mortbay/jetty/alpn/alpn-boot/8.1.13.v20181017/alpn-boot-8.1.13.v20181017.jar
    
  * Goto JVM folder
    ```
    > cd /usr/lib/jvm
    ```
  * Download jar file
    ```
    > wget http://central.maven.org/maven2/org/mortbay/jetty/alpn/alpn-boot/8.1.13.v20181017/alpn-boot-8.1.13.v20181017.jar
    ```
  * Goto folder
    ```
    > cd /etc/default
    ```
  * Open for editing **jenkins** file
  * Modify property **JAVA_ARGS** variable
    from
    ```
    JAVA_ARGS="-Djava.awt.headless=true"
    ```
    too
    ```
    JAVA_ARGS="-Djava.awt.headless=true -Xbootclasspath/p:/usr/lib/jvm/alpn-boot-8.1.13.v20181017.jar -Dhudson.DNSMultiCast.disabled=true"
    ```
  * Restart Jenkins
    ```
    systemctl stop jenkins && systemctl start jenkins
    ```



