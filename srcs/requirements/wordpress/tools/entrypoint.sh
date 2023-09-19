#!/bin/bash
#---------- definir le user admin et le user pas admin ----------#

# sleep 10 # wait for mariadb to be ready --> ajouté dans le docker-compose

mkdir -p /run/php #pour creer le dossier php-fpm
cd /var/www/wordpress #pour se placer dans le dossier wordpress

# if ! wp-config.php, le creer
wp config create --allow-root \
				 --dbname=$DB_NAME \
				 --dbuser=$DB_USER \
				 --dbpass=$DB_PASSWORD \
				 --dbhost=$DB_HOST:3306 \
				#  --path='/var/www/wordpress'
				# --dbhost=mariadb:3306 \ #si on utilise le nom du service dans le docker-compose

#pour configurer le econd utilisateur et qu il se connect autoumatiquement
wp core install --allow-root \
				--url=$WP_URL \
				--title=$WP_TITLE \
				--admin_user=$WP_ADMIN_NAME \
				--admin_password=$WP_ADMIN_PWD \
				--skip-email \
				--path='/var/www/wordpress'

wp user create --allow-root \
				$WP_USER_NAME \
				$WP_USER_EMAIL \
				--role=author \
				--user_pass=$WP_USER_PWD \
				# --path='/var/www/wordpress' #pas besoin car deja dans le dossier

/usr/sbin/php-fpm7.3 --nodaemonize #pour lancer php-fpm en foreground (1er plan)