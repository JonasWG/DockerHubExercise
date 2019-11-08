FROM ubuntu:latest

MAINTAINER Jonas

RUN apt-get update

RUN apt-get -y install apache2

COPY index.html /var/www/html/

RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

RUN cat /proc/self/cgroup | head -1 | tr --delete '10:memory:/docker/' > /var/www/html/node_name.txt

ENV APACHE_LOCK_DIR /var/log/apache2


RUN mkdir -p $APACHE_RUN_USER
RUN mkdir -p $APACHE_LOCK_DIR
RUN mkdir -p $APACHE_LOG_DIR

EXPOSE 80

ENTRYPOINT [ "/usr/sbin/apachectl" ]
CMD ["-D", "FOREGROUND"]
