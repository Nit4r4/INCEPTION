FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y 
# -y = yes authorise les demandes
RUN apt-get install php php-mysqli php-fpm wget mariadb-client -y
#The abbreviation PHP initially stood for Personal Homepage. 
#But now it is a recursive acronym for Hypertext Preprocessor.

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d
COPY ./tools/ /usr/local/bin

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.3", "--nodaemonize"]