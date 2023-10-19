#Create user
#l.9 cree la table de data
#l.10 cree un user 
#l.11 a qui on donne tous les droits = administrateur
#l.12 on change le mot de passe et les droits root pour limiter l'acces a l'admin
#l.13 rafraichir tout cela pour que MySQL le prenne en compte
touch /tmp/init_db.sql
# cat << EOF < /tmp/init_db.sql
echo "
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('rootPwd');
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
FLUSH PRIVILEGES;
# EOF
" > /tmp/init_db.sql


# mysql -h localhost < /tmp/init_db.sql # on demarre mysql dans le Dockerfile end demarrant le script
#Autoriser les connexions depuis n'importe quel hôte : Lorsque vous attribuez des autorisations à l'utilisateur MariaDB, 
#utilisez '%' comme hôte au lieu d'une adresse IP spécifique. Cela autorisera les connexions depuis n'importe quel hôte.