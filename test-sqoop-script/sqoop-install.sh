#!/bin/bash

cd
hadoop fs -copyToLocal s3://test-sqoop-script/sqoop-1.4.5.bin__hadoop-2.0.4-alpha.tar.gz sqoop-1.4.5.bin__hadoop-2.0.4-alpha.tar.gz
tar -xzf sqoop-1.4.5.bin__hadoop-2.0.4-alpha.tar.gz
hadoop fs -copyToLocal s3://test-sqoop-script/mysql-connector-java-5.1.35.tar.gz mysql-connector-java-5.1.35.tar.gz
tar -xzf mysql-connector-java-5.1.35.tar.gz
cp mysql-connector-java-5.1.35/mysql-connector-java-5.1.35-bin.jar sqoop-1.4.5.bin__hadoop-2.0.4-alpha/lib/

