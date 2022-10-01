FROM centos:centos7

MAINTAINER "Aamir M. Shaikh"

ARG user=appuser
ARG uid=1010
ARG gid=1010
ARG workspace=/var/lib/jenkins/workspace/my-declarative-pipeline

RUN yum install httpd -y

RUN yum install git -y

RUN groupadd -g $gid -r $user && useradd -u $uid -g $gid -r -m -d /home/$user -g $user $user

ADD https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz /home/$user

RUN touch index.php

RUN echo "Hello Radical" >> /home/$user/index.php

RUN chown -R $user:$user /home/$user/

RUN chmod -R 755 /home/$user

#COPY /var/tmp/index.html /tmp

COPY $workspace/webapp/target/webapp.war /var/www/html/

COPY $workspace/webapp/target/webapp /var/www/html/

#USER $user

WORKDIR /home/$user

ENV DocumentRoot=/var/www/html/

USER root

EXPOSE 80

CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]