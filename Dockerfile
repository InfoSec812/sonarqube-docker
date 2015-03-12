FROM centos:centos7
MAINTAINER Deven Phillips <deven.phillips@gmail.com>

RUN yum -y upgrade
RUN yum install -y wget java-1.7.0-openjdk-headless supervisor nginx
RUN wget -O /etc/yum.repos.d/sonar.repo http://downloads.sourceforge.net/project/sonar-pkg/rpm/sonar.repo
RUN yum --enablerepo='sonar' -y install sonar

RUN mkdir -p /usr/bin
ADD start /usr/bin/
