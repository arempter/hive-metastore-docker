#!/usr/bin/env bash

export HADOOP_LIB_PATH=${HADOOP_HOME}/share/hadoop/tools/lib
export AWS_SDK_PATH=$(ls ${HADOOP_HOME}/share/hadoop/tools/lib/ | grep aws-java-sdk-bundle)
export HADOOP_AWS_PATH=$(ls ${HADOOP_HOME}/share/hadoop/tools/lib/ | grep hadoop-aws)

export HADOOP_CLASSPATH=${HADOOP_LIB_PATH}/${AWS_SDK_PATH}:${HADOOP_LIB_PATH}/${HADOOP_AWS_PATH}

run_metastore() {
  /opt/apache-hive-metastore-3.0.0-bin/bin/schematool -initSchema -dbType mysql
  exec /opt/apache-hive-metastore-3.0.0-bin/bin/start-metastore
}

if [ $1 == 'metastore' ]; then
  run_metastore
fi

exec "$@"
