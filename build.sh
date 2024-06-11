#!/bin/bash
# 定义项目名字
PROJECT_NAME=docuseal
# 定义版本号
VERSION=$1
# 定义文件名
FILENAME=$PROJECT_NAME-$VERSION
# 定义服务器地址
SERVER_ADDRESS=apinibee.com
# 定义服务器目录
SERVER_DIR=/home/www
# 带上版本号建立docker镜像
docker build . -t $PROJECT_NAME:$VERSION
# 将docker镜像保存为tar文件
docker save $PROJECT_NAME:$VERSION -o $FILENAME.tar
# 将tar文件压缩为zip文件
zip $FILENAME.tar.zip $FILENAME.tar
# 删除tar文件
rm $FILENAME.tar
# 删除服务器之前版本的tar和zip
ssh root@$SERVER_ADDRESS "rm $SERVER_DIR/$FILENAME.tar.zip"
ssh root@$SERVER_ADDRESS "rm $SERVER_DIR/$FILENAME.tar"
# scp将zip文件上传到服务器
scp $FILENAME.tar.zip root@$SERVER_ADDRESS:$SERVER_DIR/
# 在服务器上解压zip文件
ssh root@$SERVER_ADDRESS "unzip -d $SERVER_DIR/ -o $SERVER_DIR/$FILENAME.tar.zip"
# 在服务器上删除zip文件
ssh root@$SERVER_ADDRESS "rm $SERVER_DIR/$FILENAME.tar.zip"
# 删除本地的zip文件
rm $FILENAME.tar.zip