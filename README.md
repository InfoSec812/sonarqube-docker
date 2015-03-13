SonarQube Configurable Docker Container
=======================================

## Overview

This [docker](http://docker.io/) container runs 
[SonarQube](http://www.sonarqube.org/) and allows for linking a
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

## Quick Start

- Install [fig](http://fig.sh/)
- Download the [fig.yml file](https://raw.githubusercontent.com/InfoSec812/sonarqube-docker/master/fig.yml.example) and save it as fig.yml
- Edit the fig.yml file to meet your environment's needs
- Start the container by running
```bash
fig up -d
```

## Configuration Evnironment Variables

None of the options below are 'required', but without some of them, the data stored will be lost every time the container is restarted. All default values are listed in parenthesis.

* __SONAR_CONTEXT__ (/)
  * The context path for the web application (Defaults to '/')
* __SONAR_WEB_JAVA_OPTS__ (-Xmx768m -XX:MaxPermSize=160m -XX:+HeapDumpOnOutOfMemoryError)
  * The JAVA_OPTS for the web application
* __SONAR_WEB_ADDL_OPTS__ (NULL)
  * Uses the default or provided JAVA_OPTS for the web application and appends these
* __SONAR_WEB_PORT__ (9000)
  * Port on which the web application will listen for incoming requests
* __SONAR_WEB_MAX_THREADS__ (50)
  * Maximum number of threads for the web application
* __SONAR_WEB_MIN_THREADS__ (5)
  * Minimum number of threads for the web application
* __SONAR_WEB_QUEUE__ (25)
  * Maximum number of queued requests for the web application
* __SONAR_ACCESS_LOGS__ (NULL/Disabled)
  * Enable HTTP access logs
* __SONAR_SEARCH_JAVA_OPTS__ (-Xmx1G -Xms256m -Xss256k -Djava.net.preferIPv4Stack=true -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly -XX:+HeapDumpOnOutOfMemoryError)
  * JAVA_OPTS for the Elastic Search application
* __SONAR_SEARCH_ADDL_OPTS__ (NULL/Disabled)
  * Uses the default or provided JAVA_OPTS for Elastic Search and appends these
* __SONAR_SEARCH_PORT__ (9001)
  * The port on which Elastic Search should listen for connections
* __SONAR_DISABLE_UPDATES__ (NULL/Enabled)
  * Disable SonarSource update checking
* __SONAR_PROXY_HOST__ (NULL/Disabled)
  * HTTP Proxy host for accessing the Internet
* __SONAR_PROXY_PORT__ (NULL/Disabled)
  * HTTP Proxy host for accessing the Internet
* __SONAR_SOCKS_PROXY_HOST__ (NULL/Disabled)
  * SOCKS Proxy host for accessing the Internet
* __SONAR_SOCKS_PROXY_PORT__ (NULL/Disabled)
  * SOCKS Proxy host for accessing the Internet
* __SONAR_PROXY_NTLM_DOMAIN__ (NULL/Disabled)
  * If set, the NTLM domain to use to authenticate to an NTLM authenticated proxy server
* __SONAR_PROXY_USER__ (NULL/Disabled)
  * The username with which to authenticate to the proxy
* __SONAR_PROXY_PASS__ (NULL/Disabled)
  * The password with which to authenticate to the proxy
* __SONAR_LOG_LEVEL__ (NONE)
  * The logging level (one of NONE, BASIC, FULL)
* __SONAR_EXPOSE_ELASTIC_SEARCH__ (NULL/Disabled)
  * The port on which Elastic Search should allow HTTP access
* __DB_HOST__ (127.0.0.1)
  * The host which runs the database for SonarQube
* __DB_PORT__ (9092)
  * The port on which the database listens for connections
* __DB_NAME__ (sonar)
  * The name of the database which SonarQube will use
* __DB_USER__ (sonar)
  * The username with which to authenticate to the database
* __DB_PASS__ (sonar)
  * The password with which to authenticate to the database
* __DB_TYPE__ (embedded)
  * The type of database which SonarQube will use (One of embedded,h2,postgresql,mysql,oracle,sqlserver)
* __SONAR_DB_MAX_ACTIVE__ (50)
  * Maximum number of db connections allowed
* __SONAR_DB_MAX_IDLE__ (5)
  * Maximum number of idle DB connections
* __SONAR_DB_MIN_IDLE__ (2)
  * Minimum number of spare idle DB connections
* __SONAR_DB_MAX_WAIT__ (5000)
  * Maximum amount of time to wait for a database operation (in milliseconds)
* __SONAR_DB_MIN_EVICT__ (600000)
  * Minimum time a connection must be idle before being considered for eviction from the connection pool (in milliseconds)
* __SONAR_DB_EVICT_INTERVAL__ (30000)
  * The interval at which the connection pool will consider evicting idle connections (in milliseconds)
* __SONAR_DATA_DIR__ (/data)
  * The path to the mounted docker volume where persistent data should be stored
