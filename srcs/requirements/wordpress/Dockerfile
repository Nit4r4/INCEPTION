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

#pour installer le package vim pour terminal docker
RUN apt install vim -y 

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d
COPY ./tools/ /usr/local/bin
# COPY ./conf/wp-config.php /var/www/wordpress/wp-config.php ne fonctionne quand meme pas

#copie le fichier entrypoint.sh
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
# RUN /usr/local/bin/entrypoint.sh # pas besoin, normalmeent WP le fait authomatiquement

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000
# CMD ["/usr/sbin/php-fpm7.3", "--nodaemonize"] 

#lance le script d'entrée dans le container qui lance php-fpm7.3 --nodaemonize et le service mysql start.
CMD ["/usr/local/bin/entrypoint.sh"] 