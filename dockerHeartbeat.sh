#!/bin/sh
echo "$(date +'%m/%d/%Y %H:%M:%S') ----------> Docker heartbeat script start <----------" >> /Scripts/dockerHeartbeat.log
dockerService="docker"
dockerServiceStatus="$(systemctl is-active $dockerService)"
dockerContainerName="site4000-redis"
dockerContainerStatus="$(docker container inspect $dockerContainerName | grep -Po '(?<=\"Status\":\s\")(.*)(?=\")')"
#echo $dockerServiceStatus

if [ $dockerServiceStatus = "active" ];
then
        echo "$(date +'%m/%d/%Y %H:%M:%S') ----> Docker service is already running" >> /Scripts/dockerHeartbeat.log
#       echo "if is true"
else
        systemctl start $dockerService
        echo "$(date +'%m/%d/%Y %H:%M:%S') ----> Docker service not running..started it now" >> /Scripts/dockerHeartbeat.log
        echo "Docker service restarted now $(date +'%m/%d/%Y %H:%M:%S') on E3U20-DockerRedis" | mail -s "Docker Service restarted" v@gmail.com
        echo "$(date +'%m/%d/%Y %H:%M:%S') ----> sent email for docker service restart" >> /Scripts/dockerHeartbeat.log
#       echo "if is false"
fi

sleep 3

#echo "$dockerContainerName"
#echo "$dockerContainerStatus"
if [ $dockerContainerStatus != "running" ];
then
        docker start $dockerContainerName
        echo "$(date +'%m/%d/%Y %H:%M:%S') ----> Docker container is not running...started it now" >> /Scripts/dockerHeartbeat.log
        echo "Docker container $dockerContainerName restarted now $(date +'%m/%d/%Y %H:%M:%S') on E3U20-DockerRedis" | mail -s "Docker container restarted" v@gmail.com
        echo "$(date +'%m/%d/%Y %H:%M:%S') ----> sent email for docker container restart" >> /Scripts/dockerHeartbeat.log
else
        echo "$(date +'%m/%d/%Y %H:%M:%S') ----> Docker container is already running" >> /Scripts/dockerHeartbeat.log
fi

echo "$(date +'%m/%d/%Y %H:%M:%S') -----------> Docker heartbeat script end <----------- " >> /Scripts/dockerHeartbeat.log
echo "##################################################################################" >> /Scripts/dockerHeartbeat.log
