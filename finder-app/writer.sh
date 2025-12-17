#!/bin/sh

# Description:
# - Accepts the following arguments: the first argument is a full path to a file (including filename) on the filesystem, 
#   referred to below as writefile; the second argument is a text string which will be written within this file, referred to below as writestr
# - Exits with value 1 error and print statements if any of the arguments above were not specified
# - Creates a new file with name and path writefile with content writestr, overwriting any existing file and creating 
#   the path if it doesn’t exist. Exits with value 1 and error print statement if the file could not be created.
#
# Example invocation:
#         writer.sh /tmp/aesd/assignment1/sample.txt ios
# 
# Author: jesus.loport

# full path to a file (including filename) on the filesystem
writefile=$1
# text string which will be written within this file
writestr=$2

# Exits with return value 1 error and print statements if any of the parameters above were not specified
if [ $# -lt 2 ]
then
    echo "missing arguments. usage: writer.sh <writefile> <writestr>"
    exit 1
fi

echo "writefile: $writefile"
echo "writestr: $writestr"

# Creates a new file with name and path writefile with content writestr, overwriting any existing file and creating 
# the path if it doesn’t exist. Exits with value 1 and error print statement if the file could not be created.
writedir=$(dirname $writefile)
if [ ! -d "$writedir" ]
then
    echo "creating directory $writedir"
    mkdir -p $writedir
fi

echo "creating file $writefile"
echo $writestr > $writefile

if [ $? -ne 0 ]
then
    echo "error: unable to create file $writefile"
    exit 1
fi
