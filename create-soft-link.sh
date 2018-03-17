#!/bin/sh

#######################################################
#
#  为可执行文件批量创建软连接
#
########################################################
#
#  已做的测试(macOS 10.13.3)
#
# $ cd ~/Desktop
# $ touch test1 test2 test3
# $ mkdir test4 temp
# $ /path/to/your/create-soft-link.sh . temp
#
#      /Users/chen/Desktop/temp/test1 -> /Users/chen/Desktop/test1
########################################################

#set -x

if [ $# == 1 ]; then
    sourcedir=$1
    targetdir=/usr/local/bin
elif [ $# == 2 ]; then
    sourcedir=$1
    targetdir=$2
else
    echo "Usage: /path/to/your/${0##*/} sourcedir [ targetdir(default: /usr/local/bin) ]"
    exit 1
fi

# 转为绝对路径
cd ${sourcedir}
sourcedir=`pwd`
cd - 2>&1 >> /dev/null

cd ${targetdir}
targetdir=`pwd`
cd - 2>&1 >> /dev/null

# 若为可执行文件，则开始创建软连接
ls ${sourcedir} | while read file
do
    # -f 验证普通文件，排除目录； -x 验证可执行文件
    if [ -f "${sourcedir}/${file}" ] && [ -x "${sourcedir}/${file}" ]; then
        ln -sv ${sourcedir}/${file} ${targetdir}/${file}
    fi
done

#set +x
