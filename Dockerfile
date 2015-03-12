FROM centos:centos7
MAINTAINER Deven Phillips <deven.phillips@gmail.com>

ADD docker /
RUN yum install -y wget
RUN wget -O /etc/yum.repos.d/sonar.repo http://downloads.sourceforge.net/project/sonar-pkg/rpm/sonar.repo
RUN yum --enablerepo='sonar' --enablerepo='epel-bootstrap' install -y epel-release java-1.7.0-openjdk-headless supervisor nginx sonar
RUN yum -y upgrade

RUN chmod 755 /usr/bin/start

CMD /usr/bin/start
