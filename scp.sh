
cd /root

rm -rf tar/*


#定义项目
array=(zipkin-server  spring-boot-mq  mybatis-spring-boot-kettle-engine  microservice-spring-job  microservice-gateway-zuul  spring-boot-line  microservice-frontend microservice-discovery-eureka)
#array=(spring-boot-line)

for data in ${array[@]}
do
     echo "  docker export  ${data} >  tar/${data}.tar"
     docker export  ${data} >  tar/${data}.tar
done



for data in ${array[@]}
do
    echo "远程复制命令................................................... .......................   ...............      ..........................................................."
    echo scp -r tar/${data}.tar root@118.190.113.32:/home/tar/${data}.tar
    scp -r tar/${data}.tar root@118.190.113.32:/home/tar/${data}.tar
done

echo "停止所有容器................................................... .......................   ...............      ..........................................................."
docker stop `docker ps -a|grep mapabc|awk '{print $1}'`

echo "清空垃圾镜像................................................... .......................   ...............      ..........................................................."
docker image rm `docker images |grep mapabc|awk '{print $3}'`

echo "远程启动生产服务器的所有容器................................................... .......................   ...............      .............................................."
ssh root@118.190.113.32 "/home/docker_workspace/shell/auto-build.sh"




