#!/bin/bash
service hadoop-hdfs-datanode start
service hadoop-hdfs-journalnode start
service hadoop-hdfs-namenode start
service hadoop-hdfs-secondarynamenode start
service hadoop-httpfs start
service hadoop-mapreduce-historyserver start
service hadoop-yarn-nodemanager start
service hadoop-yarn-proxyserver start
service hadoop-yarn-resourcemanager start
service hbase-master start
service hbase-regionserver start
service hbase-rest start
service hbase-solr-indexer start
service hbase-thrift start
service hive-metastore start
service hive-server2 start
service impala-catalog start
service impala-server start
service impala-state-store start
service oozie start
service solr-server start
service spark-history-server start
service sqoop2-server start
service sqoop-metastore start
service zookeeper-server start
