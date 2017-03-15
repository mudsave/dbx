#!/bin/sh 

make clean

a=$(awk '{print $1}' ./version.txt)

echo $a

cd ../..

svn revert --depth=infinity .

svn up -r $a

cd ../

svn revert --depth=infinity ./share

svn up -r $a share

cd server

make clean

make config

make all

make all

make all

cd sbin/linux

svn ci -m "Session exe commit" Session

svn ci -m "Gateway exe commit" Gateway

svn ci -m "World exe commit" World

svn ci -m "db client commit" libdbClient.so

make all
