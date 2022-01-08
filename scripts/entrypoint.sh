#!/usr/bin/env bash

export HADOOP_LIB_PATH=${HADOOP_HOME}/share/hadoop/tools/lib
export AWS_SDK_PATH=$(ls ${HADOOP_HOME}/share/hadoop/tools/lib/ | grep aws-java-sdk-bundle)
export HADOOP_AWS_PATH=$(ls ${HADOOP_HOME}/share/hadoop/tools/lib/ | grep hadoop-aws)

export HADOOP_CLASSPATH=${HADOOP_LIB_PATH}/${AWS_SDK_PATH}:${HADOOP_LIB_PATH}/${HADOOP_AWS_PATH}

run_init_schema() {
  exec /opt/apache-hive-metastore-3.0.0-bin/bin/schematool -initSchema -dbType mysql
}

run_metastore() {
  exec /opt/apache-hive-metastore-3.0.0-bin/bin/start-metastore
}

if [ $1 == 'metastore' ]; then
  run_metastore
elif [  $1 == 'init'  ]; then
  run_init_schema
fi

exec "$@"
