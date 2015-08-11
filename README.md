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
without having to restart the container if desired. Use the __docker exec__ command as follows:

```bash
docker exec -it sonarqube_sonarqube_1 /usr/bin/restart
```

## Configuration Environment Variables

None of the options below are 'required', but without some of them, the data stored will be lost every time the container is restarted. All default values are listed in parenthesis.

* sonar.jdbc.username=sonar
  * The username for authenticating to the database
* sonar.jdbc.password=sonar
  * The password for authenticating to the database
* sonar.jdbc.url=jdbc:h2:tcp://localhost:9092/sonar
  * The JDBC URL for the database
* sonar.embeddedDatabase.port=9092
  * Port on which to run the embedded H2 database engine (if desired)
* sonar.jdbc.maxActive=50
  * Maximum number of pooled database connections
* sonar.jdbc.maxIdle=5
  * Minimum number of pooled database connections
* sonar.jdbc.minIdle=2
  * Minimum number of idle database connections in the pool
* sonar.jdbc.maxWait=5000
  * Maximum amount of time to wait for a database interaction to complete
* sonar.jdbc.minEvictableIdleTimeMillis=600000
  * Minumum amount of time a database connection must be idle before being evicted from the connection pool
* sonar.jdbc.timeBetweenEvictionRunsMillis=30000
  * Amount of time to wait between eviction polls
* sonar.web.javaOpts=-Xmx768m -XX:MaxPermSize=160m -XX:+HeapDumpOnOutOfMemoryError
  * JVM options for the web application
* sonar.web.javaAdditionalOpts=
  * Additional JVM options for the web application
* sonar.web.host=0.0.0.0
  * The address on which the web server will bind to listen for requests
* sonar.web.context=
  * The web server path on which to bind (Ex: /sonar)
* sonar.web.port=9000
  * The port on which to bind the web server listener (If this is changed, you must also change the exposed port for the container)
* sonar.web.https.port=-1
  * The web server's HTTPS port (If used, you must expose the HTTPS port and install the keystore)
* sonar.web.https.keyAlias=
  * The name of the key in the keystore to use for SSL
* sonar.web.https.keyPass=changeit
  * The password for the key inside of the keystore
* sonar.web.https.keystoreFile=
  * The path to the keystore file
* sonar.web.https.keystorePass=
  * The password for the keystore file
* sonar.web.https.keystoreType=JKS
  * The type of the keystore file (JKS, PKCS12)
* sonar.web.https.keystoreProvider=
  * The name of the keystore provider
* sonar.web.https.truststoreFile=
  * The path to the keystore which contains the trusted certs
* sonar.web.https.truststorePass=
  * The password for the keystore file
* sonar.web.https.truststoreType=JKS
  * The type of the keystore file (JKS, PKCS12)
* sonar.web.https.truststoreProvider=
  * The name of the keystore provider
* sonar.web.https.clientAuth=false
  * Enable SSL certificate authentication
* sonar.web.https.ciphers=
  * Allowed ciphers (Defaults are set by the version of the JVM being used)
* sonar.web.http.maxThreads=50
  * Maximum number of HTTP threads
* sonar.web.https.maxThreads=50
  * Maximum number of HTTPS threads
* sonar.web.http.minThreads=5
  * Minimum number of HTTP threads
* sonar.web.https.minThreads=5
  * Minimum number of HTTPS threads
* sonar.web.http.acceptCount=25
  * Maximum number of queued requests to accept before denying new requests via HTTP
* sonar.web.https.acceptCount=25
  * Maximum number of queued requests to accept before denying new requests via HTTPS
* sonar.ajp.port=-1
  * Port on which to bind for use with Apache Java bridge
* sonar.search.javaOpts=-Xmx1G -Xms256m -Xss256k -Djava.net.preferIPv4Stack=true \
  * JVM options for running the embedded ElsticSearch instance
* sonar.search.javaAdditionalOpts=
  * Additional JVM options for running the embedded ElsticSearch instance
* sonar.search.port=9001
  * Port on which the ElasticSearch instance will bind
* sonar.updatecenter.activate=true
  * Enable/Disable the UpdateCenter  
* sonar.log.level=INFO
  * Log leve (FATAL, ERROR, WARN, INFO, DEBUG, TRACE)
* sonar.path.logs=logs
  * Directory path where logs will be stored
* sonar.log.rollingPolicy=time:yyyy-MM-dd
  * based on time if value starts with "time:", for example by day ("time:yyyy-MM-dd") or by month ("time:yyyy-MM")
  * based on size if value starts with "size:", for example "size:10MB"
  * disabled if value is "none".  That needs logs to be managed by an external system like logrotate
* sonar.log.maxFiles=7
  * Maximum number of files to keep if a rolling policy is enabled
* sonar.web.accessLogs.enable=true
  * Access log is the list of all the HTTP requests received by server. If enabled, it is stored in the file {sonar.path.logs}/access.log
* sonar.web.accessLogs.pattern=combined
  * Format of access log. It is ignored if sonar.web.accessLogs.enable=false
    * "common" is the Common Log Format (shortcut for: %h %l %u %user %date "%r" %s %b)
    * "combined" is another format widely recognized (shortcut for: %h %l %u [%t] "%r" %s %b "%i{Referer}" "%i{User-Agent}")
    * else a custom pattern. See http://logback.qos.ch/manual/layouts.html#AccessPatternLayout
* sonar.notifications.delay=60
  * Delay in seconds between processing of notification queue. Default is 60 seconds.
* sonar.path.data=data
  * Path to persistent data directory (embedded database and search index) and temporary files. Can be absolute or relative to installation directory.
* sonar.path.temp=temp
  * Path to persistent temp directory (embedded database and search index) and temporary files. Can be absolute or relative to installation directory.
* sonar.web.dev=false
  * Dev mode allows to reload web sources on changes and to restart server when new versions of plugins are deployed.
* sonar.web.dev.sources=/path/to/server/sonar-web/src/main/webapp
  * Path to webapp sources for hot-reloading of Ruby on Rails, JS and CSS (only core, plugins not supported).
* sonar.search.httpPort=9010
  * Uncomment to enable the Elasticsearch HTTP connector, so that ES can be directly requested through http://lmenezes.com/elasticsearch-kopf/?location=http://localhost:9010
