#!/bin/sh

# Description:
# - Accepts the following runtime arguments: the first argument is a path to a directory on the filesystem, 
#   referred to below as filesdir; the second argument is a text string which will be searched within these files, referred to below as searchstr
# - Exits with return value 1 error and print statements if any of the parameters above were not specified
# - Exits with return value 1 error and print statements if filesdir does not represent a directory on the filesystem
# - Prints a message "The number of files are X and the number of matching lines are Y" where X is the number of files 
#   in the directory and all subdirectories and Y is the number of matching lines found in respective files, where a 
#   matching line refers to a line which contains searchstr (and may also contain additional content).
#
# Example invocation:
#        finder.sh /tmp/aesd/assignment1 linux
# 
# Author: jesus.loport

# path to a directory on the filesystem
filesdir=$1

# text string which will be searched within these files
searchstr=$2

# Exits with return value 1 error and print statements if any of the parameters above were not specified
if [ $# -lt 2 ]
then
    echo "missing arguments. usage: finder.sh <filesdir> <searchstr>"
    exit 1
fi

# Exits with return value 1 error and print statements if filesdir does not represent a directory on the filesystem
if [ ! -d "$filesdir" ]
then
    echo "error: $filesdir is not a directory on the filesystem"
    exit 1
fi

echo "filesdir: $filesdir"
echo "searchstr: $searchstr"

# Prints a message "The number of files are X and the number of matching lines are Y" where X is the number of files 
# in the directory and all subdirectories and Y is the number of matching lines found in respective files, where a 
# matching line refers to a line which contains searchstr (and may also contain additional content).
filesno=$(find $filesdir -type f | wc -l)
matchno=$(grep -r $searchstr $filesdir | wc -l)

echo "The number of files are $filesno and the number of matching lines are $matchno"