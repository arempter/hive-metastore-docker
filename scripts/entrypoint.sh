#!/bin/sh

export HADOOP_HOME=/opt/hadoop-3.2.0
export HADOOP_CLASSPATH=${HADOOP_HOME}/share/hadoop/tools/lib/aws-java-sdk-bundle-1.11.375.jar:${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-aws-3.2.0.jar
export JAVA_HOME=/usr/local/openjdk-18

#this ensures that the mariadb instance is running before we try to start hive-meta

echo "sleeping for 60s to let mariadb spin up"
sleep 10
echo "sleeping for 50s.."
sleep 10
echo "sleeping for 40s"
sleep 10
echo "sleeping for 30s"
sleep 10
echo "sleeping for 20s"
sleep 10
echo "sleeping for 10s"
sleep 10
echo "tired of sleeping..time to work"

/opt/apache-hive-metastore-3.0.0-bin/bin/schematool -initSchema -dbType mysql
/opt/apache-hive-metastore-3.0.0-bin/bin/start-metastore
