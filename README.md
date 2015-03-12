SonarQube Configurable Docker Container
=======================================

## Overview

This docker container runs SonarQube and allows for linking a
SQL database container (MySQL, PostgreSQL, MSSQL, or Oracle).
You can also use an external SQL database or the embedded H2
database by setting the appropriate configuration variables.

## Prerequisites

* Docker
* Internet Access

## Building The Container

```bash
git clone https://github.com/InfoSec812/sonarqube.git
cd sonarqube
docker build -t sonarqube ./
```

## Database

By default, SonarQube supports PostgreSQL, Oracle, MSSQL, MySQL, and an 
embedded H2 database. You should be able to use any database which 
has a JDBC driver, but that would require customization of this container.

## Configuration Evnironment Variables

* SONAR_CONTEXT (/)
  * The context path for the web application (Defaults to '/')
* SONAR_WEB_JAVA_OPTS (-Xmx768m -XX:MaxPermSize=160m -XX:+HeapDumpOnOutOfMemoryError)
  * The JAVA_OPTS for the web application
* SONAR_WEB_ADDL_OPTS (NULL)
  * Uses the default or provided JAVA_OPTS for the web application and appends these
* SONAR_WEB_PORT (9000)
  * Port on which the web application will listen for incoming requests
* SONAR_WEB_MAX_THREADS (50)
  * Maximum number of threads for the web application
* SONAR_WEB_MIN_THREADS (5)
  * Minimum number of threads for the web application
* SONAR_WEB_QUEUE (25)
  * Maximum number of queued requests for the web application
* SONAR_ACCESS_LOGS (NULL/Disabled)
  * Enable HTTP access logs
* SONAR_SEARCH_JAVA_OPTS (-Xmx1G -Xms256m -Xss256k -Djava.net.preferIPv4Stack=true -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly -XX:+HeapDumpOnOutOfMemoryError)
  * JAVA_OPTS for the Elastic Search application
* SONAR_SEARCH_ADDL_OPTS (NULL/Disabled)
  * Uses the default or provided JAVA_OPTS for Elastic Search and appends these
* SONAR_SEARCH_PORT (9001)
  * The port on which Elastic Search should listen for connections
* SONAR_DISABLE_UPDATES (NULL/Enabled)
  * Disable SonarSource update checking
* SONAR_PROXY_HOST (NULL/Disabled)
  * HTTP Proxy host for accessing the Internet
* SONAR_PROXY_PORT (NULL/Disabled)
  * HTTP Proxy host for accessing the Internet
* SONAR_SOCKS_PROXY_HOST (NULL/Disabled)
  * SOCKS Proxy host for accessing the Internet
* SONAR_SOCKS_PROXY_PORT (NULL/Disabled)
  * SOCKS Proxy host for accessing the Internet
* SONAR_PROXY_NTLM_DOMAIN (NULL/Disabled)
  * If set, the NTLM domain to use to authenticate to an NTLM authenticated proxy server
* SONAR_PROXY_USER (NULL/Disabled)
  * The username with which to authenticate to the proxy
* SONAR_PROXY_PASS (NULL/Disabled)
  * The password with which to authenticate to the proxy
* SONAR_LOG_LEVEL (NONE)
  * The logging level (one of NONE, BASIC, FULL)
* SONAR_EXPOSE_ELASTIC_SEARCH (NULL/Disabled)
  * The port on which Elastic Search should allow HTTP access
* DB_HOST (127.0.0.1)
  * The host which runs the database for SonarQube
* DB_PORT (9092)
  * The port on which the database listens for connections
* DB_NAME (sonar)
  * The name of the database which SonarQube will use
* DB_USER (sonar)
  * The username with which to authenticate to the database
* DB_PASS (sonar)
  * The password with which to authenticate to the database
* DB_TYPE (embedded)
  * The type of database which SonarQube will use (One of embedded,h2,postgresql,mysql,oracle,sqlserver)
* SONAR_DB_MAX_ACTIVE (50)
  * Maximum number of db connections allowed
* SONAR_DB_MAX_IDLE (5)
  * Maximum number of idle DB connections
* SONAR_DB_MIN_IDLE (2)
  * Minimum number of spare idle DB connections
* SONAR_DB_MAX_WAIT (5000)
  * Maximum amount of time to wait for a database operation (in milliseconds)
* SONAR_DB_MIN_EVICT (600000)
  * Minimum time a connection must be idle before being considered for eviction from the connection pool (in milliseconds)
* SONAR_DB_EVICT_INTERVAL (30000)
  * The interval at which the connection pool will consider evicting idle connections (in milliseconds)
* SONAR_LOG_PATH
  * The path at which SonarQube will write logs
* SONAR_DATA_PATH
  * The path at which SonarQube will write analysis data
* SONAR_TEMP_PATH
  * The path which SonarQube will use for temp files
