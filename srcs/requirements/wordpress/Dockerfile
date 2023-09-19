FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y

# -y = yes authorise les demandes
RUN apt-get install php php-mysqli php-fpm wget mariadb-client -y
#The abbreviation PHP initially stood for Personal Homepage. 
#But now it is a recursive acronym for Hypertext Preprocessor.

#install wget dans le dossier /var/www
RUN wget https://fr.wordpress.org/wordpress-6.2.2-fr_FR.tar.gz -P /var/www
#va dans le dossier /var/www et utiliser tar -xvf suivi du fichier pour le décompresser et en obtenir le dossier  wordpress
RUN cd /var/www && tar -xzf wordpress-6.2.2-fr_FR.tar.gz && rm wordpress-6.2.2-fr_FR.tar.gz
#donner les droits à root d’écrire dans ce dossier.
RUN    chown -R root:root /var/www/wordpress
#CLI permet de configurer les infos dont a besoin WP pour fonctionner
#Une CLI c'est une interface textuelle qui traite les commandes vers un programme informatique.
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d
COPY ./tools/ /usr/local/bin

EXPOSE 9000

RUN chmod +x /entrypoint.sh

CMD ["/usr/sbin/php-fpm7.3", "--nodaemonize"]