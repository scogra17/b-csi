#!/usr/bin/env bash

# run ./parameter_expansion.sh aa bb cc
# each of the below will print aa bb cc
echo $@
echo $*
echo "$@"
echo "$*"

export IFS='-'

cnt=1

echo "Values of \"\$*\":"
for arg in "$*"
do
  echo "Arg #$cnt= $arg"
  let "cnt+=1"
done

cnt=1

echo "Values of \"\$@\":"
for arg in "$@"
do
  echo "Arg #$cnt= $arg"
  let "cnt+=1"
done

