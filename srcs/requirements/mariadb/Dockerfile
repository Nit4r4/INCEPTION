FROM debian:buster

RUN apt-get update && apt-get -y install mariadb-server mariadb-client

#on declare les variables d environnement (DB == MYQSL mais en open source again)
ARG DB_USER
ARG DB_DATABASE
ARG DB_PASSWORD
ARG DB_ROOT_PASSWORD

#on copie les fichiers dans le conteneur
COPY ./conf/50-server.conf /etc/mysql/mariadb.conf.d/ 
#on copie le scribt sh pour l executer dans le conteneur
COPY ./tools/mariadb.sh /tmp/mariadb.sh
#on authorise l execution du script et on le lance depuis le container
RUN chmod +x /tmp/mariadb.sh

#config pour demarrer MySQL 
RUN service mysql start

EXPOSE 3306

CMD ["mysql"]