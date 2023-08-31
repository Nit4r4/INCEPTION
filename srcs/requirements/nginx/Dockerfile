# Utilisation d'une image de base Debian Buster
FROM debian:buster

# Installation d'NGINX et d'autres packages nécessaires
RUN apt-get update && apt-get install -y nginx

# Copie de la configuration personnalisée d'NGINX
COPY ./nginx.conf /etc/nginx/nginx.conf

# Exposition du port 80
EXPOSE 80

# Commande de démarrage du service NGINX
CMD ["nginx", "-g", "daemon off;"]