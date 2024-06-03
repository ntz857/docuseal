#!/bin/bash
# 带上版本号建立docker镜像
docker build . -t docuseal:$1
# 将docker镜像保存为tar文件
docker save docuseal:$1 -o docuseal-$1.tar
# 将tar文件压缩为zip文件
zip docuseal-$1.tar.zip docuseal-$1.tar
