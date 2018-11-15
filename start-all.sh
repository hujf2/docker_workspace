
 docker-compose -f /root/harbor/docker-compose.yml up -d
nohup java -jar /root/jenkins.war --httpPort=18080 >/dev/null 2>&1 &
docker start some-rabbit  gitlab  nexus some-mysql
