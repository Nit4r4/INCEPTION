#!/bin/bash
#---------- definir le user admin et le user pas admin ----------#

# sleep 10 # wait for mariadb to be ready --> ajouté dans le docker-compose

mkdir -p /run/php #pour creer le dossier php-fpm

# echo "mkdir command executed successfully"

cd /var/www/wordpress #pour se placer dans le dossier wordpress


# echo "cd dans var command executed successfully"

# if ! wp-config.php, le creer
wp config create --allow-root \
				 --dbname=$DB_NAME \
				 --dbuser=$DB_USER \
				 --dbpass=$DB_PASSWORD \
				 --dbhost=$DB_HOST:3306 \
				 --path='/var/www/wordpress'
				#--config-file='/var/www/wordpress/wp-congig.php'
				# --dbhost=mariadb:3306 \ #si on utilise le nom du service dans le docker-compose

# echo "wp config create command executed successfully"

# Fix permissions for wp-config.php
chown www-data:www-data /var/www/wordpress/wp-config.php
chmod 644 /var/www/wordpress/wp-config.php

#pour configurer le econd utilisateur et qu il se connect autoumatiquement
wp core install --allow-root \
				--url=$WP_URL \
				--title=$WP_TITLE \
				--admin_user=$WP_ADMIN_USER \
				--admin_password=$WP_ADMIN_PASSWORD \
				--admin_email=$WP_ADMIN_MAIL \
				--skip-email \
				--path='/var/www/wordpress'

# echo "wp core install command executed successfully"

wp user create --allow-root \
				$WP_USER \
				$WP_USER_MAIL \
				--role=author \
				--user_pass=$WP_USER_PASSWORD \
				--path='/var/www/wordpress' #pas besoin car deja dans le dossier

# echo "user create command executed successfully"

chmod -R 755 /var/www/wordpress/wp-content

/usr/sbin/php-fpm7.3 --nodaemonize #pour lancer php-fpm en foreground (1er plan)

# echo "everything ok"

						
						
						# --------- INFOS ----------- #
# Dans ce scribt pas besoin de spécifier DB_ROOT_PASSWORD car il est destiné à la 
# configuration de WordPress, pas à la gestion de la base de données MariaDB elle-même.