#!/bin/sh

#######################################################
#
#  批量修改目录中的文件后缀
#
#  Reference: http://blog.csdn.net/victoryckl/article/details/7089752
#
########################################################
#
#  已做的测试(macOS 10.13.3)
#
# $ cd ~/Desktop
# $ touch 123.txt 456.txt "78 9.txt" 你好.txt
# $ /path/to/your/rename-file-suffix.sh ~/Desktop txt png
#
#      /Users/chen/Desktop/78 9.txt -> /Users/chen/Desktop/78 9.png
#      /Users/chen/Desktop/123.txt -> /Users/chen/Desktop/123.png
#      /Users/chen/Desktop/456.txt -> /Users/chen/Desktop/456.png
#      /Users/chen/Desktop/你好.txt -> /Users/chen/Desktop/你好.png
########################################################

#set -x

if [ "$#" != 3 ]; then
    echo "Usage: rename-file-suffix.sh dir old new"
    exit 1
fi

DIR=$1
OLD=$2
NEW=$3

find ${DIR} -name "*.${OLD}" | while read filename
do
    mv -v "${filename}"  "${filename%.${OLD}}.${NEW}"
done

#set +x
