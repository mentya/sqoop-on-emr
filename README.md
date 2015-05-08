# sqoop-on-emr

how to install Sqoop on AWS EMR Environment(hadoop 2.4)
----------------------------------------------------------------

we can use Sqoop to import and export data from a relational database such as MySQL. Here’s how I did it with MySQL. If you     are using a different database, you’ll probably need a different JDBC connector for that database.

I am using Amazon’s Hadoop version 4.0(hadoop latest version in aws) and sqoop-1.4.5

Download the sqoop version 1.4.5 for hadoop 2.O support
--------------------------------------------------------
http://www.webhostingreviewjam.com/mirror/apache/sqoop/1.4.5/sqoop-1.4.5.bin__hadoop-2.0.4-alpha.tar.gz

downloaded mysql-connector-java-5.1.35.tar.gz(download platform independet)
---------------------------------------------------------------------------
http://dev.mysql.com/downloads/connector/j/ 

% upload the two files into Amazon S3 .

Prerequisites
--------------
Create bucket name as "test-sqoop-script"(as per ur project) and upload two files(sqoop-1.4.5.bin__hadoop-2.0.4-alpha.tar.gz,mysql-connector-java-5.1.35.tar.gz)

Create the another bucket name as "test-sqoop-output"(for storing the output)

# to run the sqoop we need to write scripts
---------------------------------------------
create the sqoop-install.sh file(local system)
(write below code)

#!/bin/bash
cd
hadoop fs -copyToLocal s3://test-sqoop-script/sqoop-1.4.5.bin__hadoop-2.0.4-alpha.tar.gz sqoop-1.4.5.bin__hadoop-2.0.4-alpha.tar.gz
tar -xzf sqoop-1.4.5.bin__hadoop-2.0.4-alpha.tar.gz
hadoop fs -copyToLocal s3://test-sqoop-script/mysql-connector-java-5.1.35.tar.gz mysql-connector-java-5.1.35.tar.gz
tar -xzf mysql-connector-java-5.1.35.tar.gz
cp mysql-connector-java-5.1.35/mysql-connector-java-5.1.35-bin.jar sqoop-1.4.5.bin__hadoop-2.0.4-alpha/lib/

# to run the sqoop job
-----------------------
create the file as sqoop-job.sh(local system)

#!/bin/bash 

cd /home/hadoop/sqoop-1.4.5.bin__hadoop-2.0.4-alpha/bin

./sqoop import --connect jdbc:mysql://localhost:port/test -username root -password admin --table student --target-dir s3://test-sqoop-output/User_Profile-­‐`date +"%m-­‐%d-­‐%y_%T"` -m 1

#upload
-------------
upload two sqoop-install.sh and sqoop-job.sh into test-sqoop-script


#run
-----------
start the EMR cluster(select appropriate ami user ,EC2 keypairs & nodes)

Step 1(install sqoop)
------------

# select  steps
add step(drop down)-->select custom jar
#configure and add (click button)
give the step name

# add jar (here for running the .sh scripts we need to add common jar location

s3://elasticmapreduce/libs/script-runner/script-runner.jar

#in aruguments

s3://test-sqoop-script/sqoop-install.sh

Step 2(sqoop job run)
----------------------
add another step give appropriate name (select custom jar and add)

# add jar (here for running the .sh scripts we need to add common emr jar location

s3://elasticmapreduce/libs/script-runner/script-runner.jar

#in aruguments
s3://test-sqoop-script/sqoop-job.sh

now start the cluster after completion just check the test-sqoop-output bucket 

Hope that helped. Let me know if you have any questions


# External Links that are useful:
 -----------------------------------
 http://docs.aws.amazon.com/ElasticMapReduce/latest/DeveloperGuide/ami-versions-supported.html
 
 


