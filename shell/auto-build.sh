


cd /home
array=(zipkin-server  spring-boot-mq  mybatis-spring-boot-kettle-engine  microservice-spring-job  microservice-gateway-zuul  spring-boot-line  microservice-frontend microservice-discovery-eureka)

#array=(mybatis-spring-boot-kettle-engine)

 

declare -A map=(["microservice-frontend"]="9089" ["zipkin-server"]="9000" ["spring-boot-mq"]="9091" ["mybatis-spring-boot-kettle-engine"]="9092" ["microservice-spring-job"]="9090" ["microservice-gateway-zuul"]="8040" ["spring-boot-line"]="17070" ["microservice-discovery-eureka"]="8761" )

for data in ${array[@]}
do

    echo docker import tar/${data}.tar
    tag=`docker import tar/${data}.tar`

    #打tag
    docker tag ${tag} hub.mapabc.io/library/${data}

    echo  docker stop ${data}.tar
    docker stop ${data}

    echo   docker rm ${data}
    docker rm ${data}

    echo docker run -tid --name ${data} -p ${map[${data}]}:${map[${data}]} hub.mapabc.io/library/${data} java -jar /${data}-1.0.0-SNAPSHOT.jar   
    docker run -tid --name ${data} -p ${map[${data}]}:${map[${data}]} hub.mapabc.io/library/${data} java -jar /${data}-1.0.0-SNAPSHOT.jar
 
    #删除作废的镜像
    docker image rm `docker images |grep none|awk '{print $3}'`

    echo "======================================================================================"


done


