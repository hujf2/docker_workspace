
#!/bin/bash
#MODULE=$1
MODULE=spring-boot-line
TIME=`date  "+%Y%m%d%H%M"`
GIT_REVISION=`git log -1 --pretty=format:"%h"`
IMAGE_NAME=hub.mapabc.io/library/${MODULE}:${TIME}_${GIT_REVISION}

#cd ${MODULE} test....

docker build -t ${IMAGE_NAME} .
#cd -

docker push ${IMAGE_NAME}

#停止
docker stop ${MODULE}
#删除
docker rm ${MODULE}
#运行
docker run -tid   --name ${MODULE} -p 17070:17070  ${IMAGE_NAME}  java -jar /{MODULE}-1.0.0-SNAPSHOT.jar

echo ${IMAGE_NAME} > IMAGE_NAME

