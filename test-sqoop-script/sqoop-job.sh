#!/bin/bash 

cd /home/hadoop/sqoop-1.4.5.bin__hadoop-2.0.4-alpha/bin

./sqoop import --connect jdbc:mysql://localhost:port/test -username root -password admin --table student --target-dir s3://test-sqoop-output/User_Profile-­‐`date +"%m-­‐%d-­‐%y_%T"` -m 1


