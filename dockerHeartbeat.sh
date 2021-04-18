#!/bin/sh
echo "$(date +'%m/%d/%Y %H:%M:%S') ----------> Docker heartbeat script start <----------" >> dockerHeartbeat.log
dockerService="docker"
dockerServiceStatus="$(systemctl is-active $dockerService)"
dockerContainerName="site4000-redis"
dockerContainerStatus="$(docker container inspect $dockerContainerName | grep -Po '(?<=\"Status\":\s\")(.*)(?=\")')"
#echo $dockerServiceStatus

if [ $dockerServiceStatus = "active" ];
then
        echo "$(date +'%m/%d/%Y %H:%M:%S') ----> Docker service is already running" >> dockerHeartbeat.log
#       echo "if is true"
else
        systemctl start $dockerService
        echo "$(date +'%m/%d/%Y %H:%M:%S') ----> Docker service not running..started it now" >> dockerHeartbeat.log
#       echo "if is false"
fi

sleep 3

#echo "$dockerContainerName"
#echo "$dockerContainerStatus"
if [ $dockerContainerStatus != "running" ];
then
        docker start $dockerContainerName
        echo "$(date +'%m/%d/%Y %H:%M:%S') ----> Docker container is not running...started it now" >> dockerHeartbeat.log
else
        echo "$(date +'%m/%d/%Y %H:%M:%S') ----> Docker container is already running" >> dockerHeartbeat.log
fi

echo "$(date +'%m/%d/%Y %H:%M:%S') -----------> Docker heartbeat script end <----------- " >> dockerHeartbeat.log
