FROM openjdk:8u242-jre

WORKDIR /opt

ARG HADOOP_VERSION=3.2.0
ARG METASTORE_VERSION=3.0.0
ARG MYSQL_CONNECTOR_VERSION=8.0.19

ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV HIVE_HOME=/opt/apache-hive-metastore-${METASTORE_VERSION}-bin
ENV JAVA_HOME=/usr/local/openjdk-8


RUN curl -L https://dlcdn.apache.org/hive/hive-standalone-metastore-${METASTORE_VERSION}/hive-standalone-metastore-${METASTORE_VERSION}-bin.tar.gz | tar zxf - && \
    curl -L https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | tar zxf - && \
    curl -L https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.tar.gz | tar zxf - && \
    cp mysql-connector-java-${MYSQL_CONNECTOR_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar ${HIVE_HOME}/lib/ && \
    rm -rf  mysql-connector-java-${MYSQL_CONNECTOR_VERSION}

COPY conf/metastore-site.xml ${HIVE_HOME}/conf
COPY scripts/entrypoint.sh /entrypoint.sh

RUN groupadd -r hive --gid=1000 && \
    useradd -r -g hive --uid=1000 -d ${HIVE_HOME} hive && \
    chown hive:hive -R ${HIVE_HOME} && \
    chown hive:hive /entrypoint.sh && chmod +x /entrypoint.sh

USER hive
EXPOSE 9083

ENTRYPOINT ["/entrypoint.sh"]