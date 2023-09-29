#NGINX permet de mettre en place un serveur Web.
#FROM C’est un mot clef obligatoire et il doit toujours être en premier d’un Dockerfile

# Utilisation d'une image de base Debian Buster
FROM debian:buster

# Installation d'NGINX et d'autres packages nécessaires
# APT est un utilitaire de ligne de commande permettant d'installer, 
# de mettre à jour, de supprimer et de gérer les paquets deb sur Debian et les distributions Linux associées.

RUN apt-get update && apt upgrade -y && apt-get install -y nginx openssl

#pour installer le package vim pour terminal docker
RUN apt install vim -y 

# créer un dossier, qui permettra de stocker le certificat et la clef pour une connexion sécurisée
RUN mkdir -p /etc/nginx/ssl

# télécharger l’outil principal pour la gestion/création de certificat SSL
#req genere un certificat auto signé etx509 précise le type du certificat.
#avec l’option -nodes, notre clef privée sera sans mdp pour eviter que le build se bloque en demandant un mdp
#Il faut ensuite indiquer à OpenSSL où l’on souhaite stocker le certificat et la clef de notre SSL en rajoutant les options -out et -keyout
# l'option -subj opermet de pres remplir les infos necessaires pour le certificat
RUN openssl req -x509 -nodes \
        -out /etc/nginx/ssl/inception.crt \
        -keyout /etc/nginx/ssl/inception.key \
        -subj "/C=CH/ST=Vaud/L=Renens/O=42 Lausanne/OU=vferraro/CN=localhost/UID=vferraro"

#créer un dossier qui nous permettra de stocker les fichiers de config de NGINX
RUN mkdir -p /var/run/nginx

# Copie de la configuration personnalisée d'NGINX
COPY ./conf/ /etc/nginx/conf.d

# Exposition du port 443 port securisé
EXPOSE 443

# # test Mettre un nom ?
# ENV abc=N1t4r4

# RUN echo hello \
# world

# Commande de démarrage du service NGINX
CMD ["nginx", "-g", "daemon off;"]