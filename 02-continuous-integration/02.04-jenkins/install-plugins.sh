#!/bin/bash

echo ---- Installing Jenkins plugins ----

crumb=$(curl -s -u "admin:${1}" "http://localhost:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,\":\",//crumb)")
echo ${crumb}

plugins=(ghprb sonar pipeline-utility-steps http_request pipeline-maven)
for plugin in "${plugins[@]}"
do
  echo ---- Installing ${plugin} ----
  curl -s -o /dev/null -w "%{http_code}" POST \
    --user admin:${1} \
    -H "${crumb}" \
    --data "<jenkins><install plugin='${plugin}@latest'/></jenkins>" \
    --header 'Content-Type: text/xml' \
    http://localhost:8080/pluginManager/installNecessaryPlugins
  echo
done
