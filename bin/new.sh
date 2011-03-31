#!/bin/bash

if [ ! -d ${HOME}/shared/new/movies ]; then
    mkdir ${HOME}/shared/new/movies
fi
if [ ! -d ${HOME}/shared/new/albums ]; then
    mkdir ${HOME}/shared/new/albums
fi
rm ${HOME}/shared/new/movies/*
rm ${HOME}/shared/new/albums/*

T0=`echo '<?php print strtotime("7 days ago"); ?>' | php`

IFS="
"

cd ${HOME}/shared/new

echo "7 days ago was $T"
for i in `ls ../movies/ --time-style='+%s' -l -t -c -1`; do
  T=`echo $i | gawk '{print $6}'`
  if [ "$T" -gt "$T0" ]; then
    NAME=`echo $i | cut -d' ' -f8-50`
    ln -s "../../movies/$NAME" "movies/$NAME"
  fi
done
for i in `ls ../music/albums/ --time-style='+%s' -l -t -c -1`; do
  T=`echo $i | gawk '{print $6}'`
  if [ "$T" -gt "$T0" ]; then
    NAME=`echo $i | cut -d' ' -f8-50`
    ln -s "../../music/albums/$NAME" "albums/$NAME"
  fi
done
