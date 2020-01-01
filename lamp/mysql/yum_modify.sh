#!/bin/bash
mkdir /bak
mv /etc/yum.repos.d/* /bak/
a=`cat /etc/redhat-release |awk '{print $3}'|awk -F . '{print $1}'`
if [ $a == 6 ];then
   wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo
else
   wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
fi
yum clean all
yum makecache