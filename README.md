SonarQube Configurable Docker Container
=======================================

## Overview

This docker container runs SonarQube and allows for linking a
SQL database container (MySQL, PostgreSQL, MSSQL, or Oracle).
You can also use an external SQL database or the embedded H2
database by setting the appropriate configuration variables.

## Prerequisites

* __Docker__
* __Internet Access__

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

## Quick Start

# Install [fig](http://fig.sh/)
# Download the [fig.yml file ](https://raw.githubusercontent.com/InfoSec812/sonarqube-docker/master/fig.yml.example) and save it as fig.yml
# Edit the fig.yml file to meet your environment's needs
# Start the container by running
```bash
fig up -d
```

## Configuration Evnironment Variables

None of the options below are 'required', but without some of them, the data stored will be lost every time the container is restarted. All default values are listed in parenthesis.

* __SONAR_CONTEXT (/)__
  * The context path for the web application (Defaults to '/')
* __SONAR_WEB_JAVA_OPTS (-Xmx768m -XX:MaxPermSize=160m -XX:+HeapDumpOnOutOfMemoryError)__
  * The JAVA_OPTS for the web application
* __SONAR_WEB_ADDL_OPTS (NULL)__
  * Uses the default or provided JAVA_OPTS for the web application and appends these
* __SONAR_WEB_PORT (9000)__
  * Port on which the web application will listen for incoming requests
* __SONAR_WEB_MAX_THREADS (50)__
  * Maximum number of threads for the web application
* __SONAR_WEB_MIN_THREADS (5)__
  * Minimum number of threads for the web application
* __SONAR_WEB_QUEUE (25)__
  * Maximum number of queued requests for the web application
* __SONAR_ACCESS_LOGS (NULL/Disabled)__
  * Enable HTTP access logs
* __SONAR_SEARCH_JAVA_OPTS (-Xmx1G -Xms256m -Xss256k -Djava.net.preferIPv4Stack=true -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly -XX:+HeapDumpOnOutOfMemoryError)__
  * JAVA_OPTS for the Elastic Search application
* __SONAR_SEARCH_ADDL_OPTS (NULL/Disabled)__
  * Uses the default or provided JAVA_OPTS for Elastic Search and appends these
* __SONAR_SEARCH_PORT (9001)__
  * The port on which Elastic Search should listen for connections
* __SONAR_DISABLE_UPDATES (NULL/Enabled)__
  * Disable SonarSource update checking
* __SONAR_PROXY_HOST (NULL/Disabled)__
  * HTTP Proxy host for accessing the Internet
* __SONAR_PROXY_PORT (NULL/Disabled)__
  * HTTP Proxy host for accessing the Internet
* __SONAR_SOCKS_PROXY_HOST (NULL/Disabled)__
  * SOCKS Proxy host for accessing the Internet
* __SONAR_SOCKS_PROXY_PORT (NULL/Disabled)__
  * SOCKS Proxy host for accessing the Internet
* __SONAR_PROXY_NTLM_DOMAIN (NULL/Disabled)__
  * If set, the NTLM domain to use to authenticate to an NTLM authenticated proxy server
* __SONAR_PROXY_USER (NULL/Disabled)__
  * The username with which to authenticate to the proxy
* __SONAR_PROXY_PASS (NULL/Disabled)__
  * The password with which to authenticate to the proxy
* __SONAR_LOG_LEVEL (NONE)__
  * The logging level (one of NONE, BASIC, FULL)
* __SONAR_EXPOSE_ELASTIC_SEARCH (NULL/Disabled)__
  * The port on which Elastic Search should allow HTTP access
* __DB_HOST (127.0.0.1)__
  * The host which runs the database for SonarQube
* __DB_PORT (9092)__
  * The port on which the database listens for connections
* __DB_NAME (sonar)__
  * The name of the database which SonarQube will use
* __DB_USER (sonar)__
  * The username with which to authenticate to the database
* __DB_PASS (sonar)__
  * The password with which to authenticate to the database
* __DB_TYPE (embedded)__
  * The type of database which SonarQube will use (One of embedded,h2,postgresql,mysql,oracle,sqlserver)
* __SONAR_DB_MAX_ACTIVE (50)__
  * Maximum number of db connections allowed
* __SONAR_DB_MAX_IDLE (5)__
  * Maximum number of idle DB connections
* __SONAR_DB_MIN_IDLE (2)__
  * Minimum number of spare idle DB connections
* __SONAR_DB_MAX_WAIT (5000)__
  * Maximum amount of time to wait for a database operation (in milliseconds)
* __SONAR_DB_MIN_EVICT (600000)__
  * Minimum time a connection must be idle before being considered for eviction from the connection pool (in milliseconds)
* __SONAR_DB_EVICT_INTERVAL (30000)__
  * The interval at which the connection pool will consider evicting idle connections (in milliseconds)
* __SONAR_LOG_PATH__ (/data/sonar/logs)
  * The path at which SonarQube will write logs
* __SONAR_DATA_PATH__ (/data/sonar/data)
  * The path at which SonarQube will write analysis data
* __SONAR_TEMP_PATH__ (/data/sonar/temp)
  * The path which SonarQube will use for temp files
