## Docker file for Hive Metastore 3 standalone

### About

Example of running standalone Hive Metastore. Minio is used as S3 storage for external
tables.  

It contains following containers:
- mariadb as dependency
- minio to test S3 access (make sure that you specify correct volume to be mounted)
- hive metastore  3.x
- Pyspark 3.3.x and Pandas

### How to run

use docker compose to build && start hive

```
$ docker-compose build
$ docker-compose up -d
```

You can now connect to it using hive or spark application.

### Hive

Download and untar hive first.  
Then copy conf/metastore-site.xml to hive $HIVE_HOME/conf/hive-site.xml

Before running hive make sure you export:
```
export JAVA_HOME=/java/home
export HADOOP_HOME=/your/local/hadoop/path
export HADOOP_CLASSPATH=${HADOOP_HOME}/share/hadoop/tools/lib/aws-java-sdk-bundle-1.11.375.jar:${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-aws-3.2.0.jar
``` 

`HADOOP_CLASSPATH` is not mandatory if you do not want to use S3 


then run:

```
$ $HIVE_HOME/bin/hive
``` 

you shuld see some hive objects if connection works correctly

```
hive> show tables;
OK
example_table3
Time taken: 0.024 seconds, Fetched: 1 row(s)
```

### Spark

For spark use:

```
val spark = SparkSession
      .builder()
      .appName("SparkHiveTest")
      .config("hive.metastore.uris", "thrift://localhost:9083")
      .config("spark.sql.warehouse.dir", warehouseLocation)
      .enableHiveSupport()
      .getOrCreate()
```

