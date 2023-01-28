FROM centos:centos7

ARG user=appuser
ARG uid=1010
ARG gid=1010

RUN yum install httpd -y

RUN yum install git -y

RUN groupadd -g $gid -r $user && useradd -u $uid -g $gid -r -m -d /home/$user -g $user $user

ADD https://dlcdn.apache.org/maven/maven-3/3.8.7/binaries/apache-maven-3.8.7-bin.tar.gz /home/$user

RUN touch index.php

RUN echo "Hello Radical" >> /home/$user/index.php

RUN chown -R $user:$user /home/$user/

RUN chmod -R 755 /home/$user

#COPY /var/tmp/index.html /tmp

COPY webapp.war /var/www/html/

COPY webapp /var/www/html/

#USER $user

WORKDIR /home/$user

ENV DocumentRoot=/var/www/html/

USER root

EXPOSE 80

CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]