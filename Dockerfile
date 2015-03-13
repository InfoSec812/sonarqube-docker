FROM centos:centos7
MAINTAINER Deven Phillips <deven.phillips@gmail.com>

ADD docker/etc/yum.repos.d/* /etc/yum.repos.d/
RUN yum --enablerepo='epel-bootstrap' install -y epel-release unzip python python-pip
RUN yum -y upgrade
RUN curl -o jdk8.rpm -sSf -L --cookie "oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jdk-8u20-linux-x64.rpm && rpm -ivh jdk8.rpm && rm -f jdk8.rpm
RUN pip install supervisor
WORKDIR /opt
RUN curl -s -o sonarqube.zip http://dist.sonar.codehaus.org/sonarqube-5.0.1.zip
RUN unzip sonarqube.zip && mv sonarqube-5.0.1 sonar && rm -f sonarqube.zip
ADD docker /
RUN chmod 755 /usr/bin/start

CMD /usr/bin/start
