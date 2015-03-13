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

- Install [docker-compose](http://docs.docker.com/compose/)
- Download the [docker-compose.yml file](https://raw.githubusercontent.com/InfoSec812/sonarqube-docker/master/docker-compose.yml.example) and save it as docker-compose.yml
- Edit the docker-compose.yml file to meet your environment's needs
- Start the container by running
```bash
docker-compose up -d
```

## Upgrading

In most cases, upgrading from one version of this container to the next consists of:
- Stop the container
- Delete <DATA_DIR>/data/es directory
- Pull the new version of the container
- Start the new container
- Browse to http(s)://yourserver/upgrade
- Follow upgrade instructions

You may need to adjust the URL above depending on your configuration. Also, upgrading plugins may be required.

## Restarting the SonarQube Service

In order to install/upgrade plugins you need to restart the SonarQube service. You can do so 
without having to restart the container if desired. Use the __docker exec__ command to enter the running container
and then issue a __kill -9__ command to force supervisord to restart the service.

EXAMPLE:
```bash
$ docker ps | grep sonar
5dc3df48b34c        infosec812/sonarqube:5.0.1   "/bin/sh -c /usr/bin   14 minutes ago      Up 14 minutes       0.0.0.0:9000->9000/tcp                                  sonarqube_sonarqube_1 
$ docker exec -i -t sonarqube_sonarqube_1 /bin/bash
$ ps ax | grep java
   66 ?        Sl     0:01 java -Djava.awt.headless=true -Xms3m -Xmx32m -Djava.library.path=./lib -classpath ../../lib/jsw/wrapper-3.2.3.jar:../../lib/sonar-application-5.0.1.jar -Dwrapper.key=SUsO34i7qsG0udi_ -Dwrapper.port=32000 -Dwrapper.jvm.port.min=31000 -Dwrapper.jvm.port.max=31999 -Dwrapper.pid=64 -Dwrapper.version=3.2.3 -Dwrapper.native_library=wrapper -Dwrapper.cpu.timeout=10 -Dwrapper.jvmid=1 org.tanukisoftware.wrapper.WrapperSimpleApp org.sonar.application.App
   91 ?        Sl     0:41 /usr/java/jdk1.8.0_20/jre/bin/java -Djava.awt.headless=true -Xmx1G -Xms256m -Xss256k -Djava.net.preferIPv4Stack=true -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly -XX:+HeapDumpOnOutOfMemoryError -Djava.io.tmpdir=/data/temp -cp ./lib/common/*:./lib/search/* org.sonar.search.SearchServer /tmp/sq-process3534710488578140315properties
  169 ?        Sl     1:08 /usr/java/jdk1.8.0_20/jre/bin/java -Djava.awt.headless=true -Dfile.encoding=UTF-8 -Djruby.management.enabled=false -Djruby.compile.invokedynamic=false -Xmx768m -XX:MaxPermSize=160m -XX:+HeapDumpOnOutOfMemoryError -Djava.net.preferIPv4Stack=true -Djava.io.tmpdir=/data/temp -cp ./lib/common/*:./lib/server/*:/opt/sonar/lib/jdbc/postgresql/postgresql-9.3-1101-jdbc4.jar org.sonar.server.app.WebServer /tmp/sq-process3177121203749324429properties
  303 ?        S+     0:00 grep --color=auto java
$ kill -9 66 91 169
$ supervisorctl stop sonarqube
$ supervisorctl start sonarqube
$ exit
```

## Configuration Environment Variables

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
