FROM debian:buster

RUN apt-get update
RUN apt-get -y install mariadb-server mariadb-client
# RUN apt-get install mysql-server
# RUN wget https://dev.mysql.com/get/mysql-apt-config_0.8.15-1_all.deb
#on declare les variables d environnement (ARGS) ici et on les initialise dans le compose pour etre capable de les utiliser dans le script mariadb.sh (DB == MYQSL mais en open source again)
ARG DB_USER
ARG DB_NAME
ARG DB_PASSWORD
ARG DB_ROOT_PASSWORD

#on copie les fichiers dans le conteneur
COPY ./conf/my.cnf /etc/mysql/my.cnf
#on copie le scribt sh pour l executer dans le conteneur
COPY ./tools/mariadb.sh /tmp/mariadb.sh

#TEST
# COPY ./tools/init_db.sql.template /tmp/init_db.sql.template

#pour installer le package vim pour terminal docker
RUN apt install vim -y

#on authorise l execution du script et on le lance depuis le container
RUN chmod +x /tmp/mariadb.sh

#On creer un dossier data et on lui donne les droits pour que mysql puisse y acceder
#-p permet de creer le dossier parent si il n existe pas et ne fait rien si il existe deja.
RUN mkdir data && mkdir -p var/run/mysqld/ \ 
&& chown -R mysql:mysql /var/run/mysqld \
&& chmod 777 /var/run/mysqld

RUN /tmp/mariadb.sh
#config pour demarrer MySQL 
# RUN service mysql start pas besion de le RUN pusiqu on le demarre avec CMD plus bas

EXPOSE 3306

#on lance le service mysql et -u pour lancer mysql en tant que user mysql autrement le lance en mode root (pas bien)
CMD ["mysqld", "-u", "mysql", "--init-file", "/tmp/init_db.sql"]