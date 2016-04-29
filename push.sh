#! /bin/bash


git add --all

git commit -am "$(date): $1"

git push origin master 
