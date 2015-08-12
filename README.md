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
cd **sonarqube**
make docker
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
- Create a "data" directory for storing persistent information from SonarQube
- Edit the docker-compose.yml file to meet your environment's needs, including setting the "data" volume to the directory created in the previous step.
- Start the container by running
```bash
docker-compose up -d
```

By default, this container will use the embedded H2 database running on port 9092 (which you will need to export from the container). To access the embedded DB
you will need to modify the docker-compose.yml file to expose the database port as shown below:

```
sonarqube:
  image: infosec812/sonarqube:5.1.2
  ports:
    - "9000:9000"
    - "9092:9092"
  name:
    - "sonarqube"
  volumes:
    - "/path/to/persistent/data:/data"
  command: /usr/bin/start
```

If you want to use an external database,
you will need to pass in the options detailed in the README.md file (below). The easiest way to accomplish this is to modify the docker-compose.yml file
to set up the required environment variables as demonstrated below for an external PostgreSQL database. 

```
sonarqube:
  image: infosec812/sonarqube:5.1.2
  ports:
    - "9000:9000"
  name:
    - "sonarqube"
  environment:
    sonar__jdbc__url: jdbc:postgresql://192.168.1.210:5432/sonar
    sonar__jdbc__username: sonar
    sonar__jdbc__password: sonar
  volumes:
    - "/path/to/persistent/data:/data"
  command: /usr/bin/start
```

This will configure SonarQube to connect to an external PostgreSQL database with an IP address of '192.168.1.210' using the user/pass of "sonar/sonar". The database "sonar"
will have to already have been created manually, but SonarQube will create all of the required tables and database schema.


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
docker exec -it **sonarqube_sonarqube_1 /usr/bin/restart
```

## Configuration Environment Variables

None of the options below are 'required', but without some of them, the data stored will be lost every time the container is restarted. All default values are listed in parenthesis.

* **sonar\_\_jdbc\_\_username**=sonar
  * The username for authenticating to the database
* **sonar\_\_jdbc\_\_password**=sonar
  * The password for authenticating to the database
* **sonar\_\_jdbc\_\_url**=jdbc:h2:tcp://localhost:9092/sonar
  * The JDBC URL for the database
* **sonar\_\_embeddedDatabase\_\_port**=9092
  * Port on which to run the embedded H2 database engine (if desired)
* **sonar\_\_jdbc\_\_maxActive**=50
  * Maximum number of pooled database connections
* **sonar\_\_jdbc\_\_maxIdle**=5
  * Minimum number of pooled database connections
* **sonar\_\_jdbc\_\_minIdle**=2
  * Minimum number of idle database connections in the pool
* **sonar\_\_jdbc\_\_maxWait**=5000
  * Maximum amount of time to wait for a database interaction to complete
* **sonar\_\_jdbc\_\_minEvictableIdleTimeMillis**=600000
  * Minumum amount of time a database connection must be idle before being evicted from the connection pool
* **sonar\_\_jdbc\_\_timeBetweenEvictionRunsMillis**=30000
  * Amount of time to wait between eviction polls
* **sonar\_\_web\_\_javaOpts**=-Xmx768m -XX:MaxPermSize**=160m -XX:+HeapDumpOnOutOfMemoryError
  * JVM options for the web application
* **sonar\_\_web\_\_javaAdditionalOpts**=
  * Additional JVM options for the web application
* **sonar\_\_web\_\_host**=0.0.0.0
  * The address on which the web server will bind to listen for requests
* **sonar\_\_web\_\_context**=
  * The web server path on which to bind (Ex: /sonar)
* **sonar\_\_web\_\_port**=9000
  * The port on which to bind the web server listener (If this is changed, you must also change the exposed port for the container)
* **sonar\_\_web\_\_https\_\_port**=-1
  * The web server's HTTPS port (If used, you must expose the HTTPS port and install the keystore)
* **sonar\_\_web\_\_https\_\_keyAlias**=
  * The name of the key in the keystore to use for SSL
* **sonar\_\_web\_\_https\_\_keyPass**=changeit
  * The password for the key inside of the keystore
* **sonar\_\_web\_\_https\_\_keystoreFile**=
  * The path to the keystore file
* **sonar\_\_web\_\_https\_\_keystorePass**=
  * The password for the keystore file
* **sonar\_\_web\_\_https\_\_keystoreType**=JKS
  * The type of the keystore file (JKS, PKCS12)
* **sonar\_\_web\_\_https\_\_keystoreProvider**=
  * The name of the keystore provider
* **sonar\_\_web\_\_https\_\_truststoreFile**=
  * The path to the keystore which contains the trusted certs
* **sonar\_\_web\_\_https\_\_truststorePass**=
  * The password for the keystore file
* **sonar\_\_web\_\_https\_\_truststoreType**=JKS
  * The type of the keystore file (JKS, PKCS12)
* **sonar\_\_web\_\_https\_\_truststoreProvider**=
  * The name of the keystore provider
* **sonar\_\_web\_\_https\_\_clientAuth**=false
  * Enable SSL certificate authentication
* **sonar\_\_web\_\_https\_\_ciphers**=
  * Allowed ciphers (Defaults are set by the version of the JVM being used)
* **sonar\_\_web\_\_http\_\_maxThreads**=50
  * Maximum number of HTTP threads
* **sonar\_\_web\_\_https\_\_maxThreads**=50
  * Maximum number of HTTPS threads
* **sonar\_\_web\_\_http\_\_minThreads**=5
  * Minimum number of HTTP threads
* **sonar\_\_web\_\_https\_\_minThreads**=5
  * Minimum number of HTTPS threads
* **sonar\_\_web\_\_http\_\_acceptCount**=25
  * Maximum number of queued requests to accept before denying new requests via HTTP
* **sonar\_\_web\_\_https\_\_acceptCount**=25
  * Maximum number of queued requests to accept before denying new requests via HTTPS
* **sonar\_\_ajp\_\_port**=-1
  * Port on which to bind for use with Apache Java bridge
* **sonar\_\_search\_\_javaOpts**=-Xmx1G -Xms256m -Xss256k -Djava\_\_net\_\_preferIPv4Stack**=true \
  * JVM options for running the embedded ElsticSearch instance
* **sonar\_\_search\_\_javaAdditionalOpts**=
  * Additional JVM options for running the embedded ElsticSearch instance
* **sonar\_\_search\_\_port**=9001
  * Port on which the ElasticSearch instance will bind
* **sonar\_\_updatecenter\_\_activate**=true
  * Enable/Disable the UpdateCenter  
* **sonar\_\_log\_\_level**=INFO
  * Log leve (FATAL, ERROR, WARN, INFO, DEBUG, TRACE)
* **sonar\_\_path\_\_logs**=logs
  * Directory path where logs will be stored
* **sonar\_\_log\_\_rollingPolicy**=time:yyyy-MM-dd
  * based on time if value starts with "time:", for example by day ("time:yyyy-MM-dd") or by month ("time:yyyy-MM")
  * based on size if value starts with "size:", for example "size:10MB"
  * disabled if value is "none".  That needs logs to be managed by an external system like logrotate
* **sonar\_\_log\_\_maxFiles**=7
  * Maximum number of files to keep if a rolling policy is enabled
* **sonar\_\_web\_\_accessLogs\_\_enable**=true
  * Access log is the list of all the HTTP requests received by server. If enabled, it is stored in the file {sonar\_\_path\_\_logs}/access\_\_log
* **sonar\_\_web\_\_accessLogs\_\_pattern**=combined
  * Format of access log. It is ignored if sonar.web.accessLogs.enable=false
    * "common" is the Common Log Format (shortcut for: %h %l %u %user %date "%r" %s %b)
    * "combined" is another format widely recognized (shortcut for: %h %l %u [%t] "%r" %s %b "%i{Referer}" "%i{User-Agent}")
    * else a custom pattern. See http://logback.qos.ch/manual/layouts.html#AccessPatternLayout
* **sonar\_\_notifications\_\_delay**=60
  * Delay in seconds between processing of notification queue. Default is 60 seconds.
* **sonar\_\_path\_\_data**=data
  * Path to persistent data directory (embedded database and search index) and temporary files. Can be absolute or relative to installation directory.
* **sonar\_\_path\_\_temp**=temp
  * Path to persistent temp directory (embedded database and search index) and temporary files. Can be absolute or relative to installation directory.
* **sonar\_\_web\_\_dev**=false
  * Dev mode allows to reload web sources on changes and to restart server when new versions of plugins are deployed.
* **sonar\_\_web\_\_dev\_\_sources**=/path/to/server/sonar-web/src/main/webapp
  * Path to webapp sources for hot-reloading of Ruby on Rails, JS and CSS (only core, plugins not supported).
* **sonar\_\_search\_\_httpPort**=9010
  * Uncomment to enable the Elasticsearch HTTP connector, so that ES can be directly requested through http://lmenezes.com/elasticsearch-kopf/?location=http://localhost:9010
