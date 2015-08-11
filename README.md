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
cd _sonarqube
docker build -t _sonarqube ./
```

## Database

By default, SonarQube supports PostgreSQL, Oracle, MSSQL, MySQL, and an 
embedded H2 database. You should be able to use any database which 
has a JDBC driver, but that would require customization of this container.
After running the container a single time with the H2 driver, the data
volume will be populated with the defaults and you could then add the JDBC
driver to <data>/sonar/extensions/jdbc-driver/<dbtype>/<jdbc driver jar file>.

For example, to enable Oracle as the database:
* Pull/Build the container
* Run the container using docker-compose and a data volume configured
* Stop the container
* Create a directory <data>/sonar/extensions/jdbc-driver/oracle
* Copy the Oracle JDBC driver to that new directory
* Update the docker-compose.yaml file to use the appropriate jdbc settings
* Start the container using docker-compose

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
without having to restart the container if desired. Use the \_\_docker exec\_\_ command as follows:

```bash
docker exec -it _sonarqube_sonarqube_1 /usr/bin/restart
```

## Configuration Environment Variables

None of the options below are 'required', but without some of them, the data stored will be lost every time the container is restarted. All default values are listed in parenthesis.

* _sonar\_\_jdbc\_\_username_=sonar
  * The username for authenticating to the database
* _sonar\_\_jdbc\_\_password_=sonar
  * The password for authenticating to the database
* _sonar\_\_jdbc\_\_url_=jdbc:h2:tcp://localhost:9092/sonar
  * The JDBC URL for the database
* _sonar\_\_embeddedDatabase\_\_port_=9092
  * Port on which to run the embedded H2 database engine (if desired)
* _sonar\_\_jdbc\_\_maxActive_=50
  * Maximum number of pooled database connections
* _sonar\_\_jdbc\_\_maxIdle_=5
  * Minimum number of pooled database connections
* _sonar\_\_jdbc\_\_minIdle_=2
  * Minimum number of idle database connections in the pool
* _sonar\_\_jdbc\_\_maxWait_=5000
  * Maximum amount of time to wait for a database interaction to complete
* _sonar\_\_jdbc\_\_minEvictableIdleTimeMillis_=600000
  * Minumum amount of time a database connection must be idle before being evicted from the connection pool
* _sonar\_\_jdbc\_\_timeBetweenEvictionRunsMillis_=30000
  * Amount of time to wait between eviction polls
* _sonar\_\_web\_\_javaOpts_=-Xmx768m -XX:MaxPermSize_=160m -XX:+HeapDumpOnOutOfMemoryError
  * JVM options for the web application
* _sonar\_\_web\_\_javaAdditionalOpts_=
  * Additional JVM options for the web application
* _sonar\_\_web\_\_host_=0.0.0.0
  * The address on which the web server will bind to listen for requests
* _sonar\_\_web\_\_context_=
  * The web server path on which to bind (Ex: /sonar)
* _sonar\_\_web\_\_port_=9000
  * The port on which to bind the web server listener (If this is changed, you must also change the exposed port for the container)
* _sonar\_\_web\_\_https\_\_port_=-1
  * The web server's HTTPS port (If used, you must expose the HTTPS port and install the keystore)
* _sonar\_\_web\_\_https\_\_keyAlias_=
  * The name of the key in the keystore to use for SSL
* _sonar\_\_web\_\_https\_\_keyPass_=changeit
  * The password for the key inside of the keystore
* _sonar\_\_web\_\_https\_\_keystoreFile_=
  * The path to the keystore file
* _sonar\_\_web\_\_https\_\_keystorePass_=
  * The password for the keystore file
* _sonar\_\_web\_\_https\_\_keystoreType_=JKS
  * The type of the keystore file (JKS, PKCS12)
* _sonar\_\_web\_\_https\_\_keystoreProvider_=
  * The name of the keystore provider
* _sonar\_\_web\_\_https\_\_truststoreFile_=
  * The path to the keystore which contains the trusted certs
* _sonar\_\_web\_\_https\_\_truststorePass_=
  * The password for the keystore file
* _sonar\_\_web\_\_https\_\_truststoreType_=JKS
  * The type of the keystore file (JKS, PKCS12)
* _sonar\_\_web\_\_https\_\_truststoreProvider_=
  * The name of the keystore provider
* _sonar\_\_web\_\_https\_\_clientAuth_=false
  * Enable SSL certificate authentication
* _sonar\_\_web\_\_https\_\_ciphers_=
  * Allowed ciphers (Defaults are set by the version of the JVM being used)
* _sonar\_\_web\_\_http\_\_maxThreads_=50
  * Maximum number of HTTP threads
* _sonar\_\_web\_\_https\_\_maxThreads_=50
  * Maximum number of HTTPS threads
* _sonar\_\_web\_\_http\_\_minThreads_=5
  * Minimum number of HTTP threads
* _sonar\_\_web\_\_https\_\_minThreads_=5
  * Minimum number of HTTPS threads
* _sonar\_\_web\_\_http\_\_acceptCount_=25
  * Maximum number of queued requests to accept before denying new requests via HTTP
* _sonar\_\_web\_\_https\_\_acceptCount_=25
  * Maximum number of queued requests to accept before denying new requests via HTTPS
* _sonar\_\_ajp\_\_port_=-1
  * Port on which to bind for use with Apache Java bridge
* _sonar\_\_search\_\_javaOpts_=-Xmx1G -Xms256m -Xss256k -Djava\_\_net\_\_preferIPv4Stack_=true \
  * JVM options for running the embedded ElsticSearch instance
* _sonar\_\_search\_\_javaAdditionalOpts_=
  * Additional JVM options for running the embedded ElsticSearch instance
* _sonar\_\_search\_\_port_=9001
  * Port on which the ElasticSearch instance will bind
* _sonar\_\_updatecenter\_\_activate_=true
  * Enable/Disable the UpdateCenter  
* _sonar\_\_log\_\_level_=INFO
  * Log leve (FATAL, ERROR, WARN, INFO, DEBUG, TRACE)
* _sonar\_\_path\_\_logs_=logs
  * Directory path where logs will be stored
* _sonar\_\_log\_\_rollingPolicy_=time:yyyy-MM-dd
  * based on time if value starts with "time:", for example by day ("time:yyyy-MM-dd") or by month ("time:yyyy-MM")
  * based on size if value starts with "size:", for example "size:10MB"
  * disabled if value is "none".  That needs logs to be managed by an external system like logrotate
* _sonar\_\_log\_\_maxFiles_=7
  * Maximum number of files to keep if a rolling policy is enabled
* _sonar\_\_web\_\_accessLogs\_\_enable_=true
  * Access log is the list of all the HTTP requests received by server. If enabled, it is stored in the file {sonar\_\_path\_\_logs}/access\_\_log
* _sonar\_\_web\_\_accessLogs\_\_pattern_=combined
  * Format of access log. It is ignored if _sonar\_\_web\_\_accessLogs\_\_enable_=false
    * "common" is the Common Log Format (shortcut for: %h %l %u %user %date "%r" %s %b)
    * "combined" is another format widely recognized (shortcut for: %h %l %u [%t] "%r" %s %b "%i{Referer}" "%i{User-Agent}")
    * else a custom pattern. See http://logback\_\_qos\_\_ch/manual/layouts\_\_html#AccessPatternLayout
* _sonar\_\_notifications\_\_delay_=60
  * Delay in seconds between processing of notification queue. Default is 60 seconds.
* _sonar\_\_path\_\_data_=data
  * Path to persistent data directory (embedded database and search index) and temporary files. Can be absolute or relative to installation directory.
* _sonar\_\_path\_\_temp_=temp
  * Path to persistent temp directory (embedded database and search index) and temporary files. Can be absolute or relative to installation directory.
* _sonar\_\_web\_\_dev_=false
  * Dev mode allows to reload web sources on changes and to restart server when new versions of plugins are deployed.
* _sonar\_\_web\_\_dev\_\_sources_=/path/to/server/sonar-web/src/main/webapp
  * Path to webapp sources for hot-reloading of Ruby on Rails, JS and CSS (only core, plugins not supported).
* _sonar\_\_search\_\_httpPort_=9010
  * Uncomment to enable the Elasticsearch HTTP connector, so that ES can be directly requested through http://lmenezes\_\_com/elasticsearch-kopf/?location_=http://localhost:9010
