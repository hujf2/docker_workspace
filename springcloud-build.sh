
#!/bin/bash
MODULE=$1
PARENT=$2
PORTS=$3
DIR="/root/.jenkins/workspace"


#进入到相应的文件夹
cd ${DIR}/${PARENT}/${MODULE}

TIME=`date  "+%Y%m%d%H%M"`
GIT_REVISION=`git log -1 --pretty=format:"%h"`
IMAGE_NAME=hub.mapabc.io/library/${MODULE}:${TIME}_${GIT_REVISION}



docker build -t ${IMAGE_NAME} .
#cd -

docker push ${IMAGE_NAME}

#停止
docker stop ${MODULE}
#删除
docker rm ${MODULE}
#运行
docker run -tid   --name ${MODULE} -p ${PORTS}  ${IMAGE_NAME}  java -jar /{MODULE}-1.0.0-SNAPSHOT.jar

echo ${IMAGE_NAME} > IMAGE_NAME

