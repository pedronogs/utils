#!/bin/bash

# This script is made to convert Window's file names to all systems 
# Basically, 
#   spaces => nothing, 
#   period and comma => underline, 
#   upper case => lower case
#   (x) => underline number (example: (2) => _2)

directory=$1

if [ -e "$directory" ] && [ -d "$directory" ];
    then
        ls "$directory" | while read dirty_file;
            do 
                extension=`echo "$dirty_file" | sed -r 's/.*(\..*)$/\1/g'`
                without_extension=`echo "$dirty_file" | sed -r 's/(.*)\..*$/\1/g'`
                
                sanitized=`echo "$without_extension" | sed -r -e 's/ //g' -e 's/,/_/g' -e 's/\./\-/g' -e 's/\((.*)\)/_\1/g' -e 's/(.*)/\L\1/g'`

                mv -v "${directory}${dirty_file}" "${directory}${sanitized}${extension}"
            done
    else
        echo "Please supply a directory as argument."
fi