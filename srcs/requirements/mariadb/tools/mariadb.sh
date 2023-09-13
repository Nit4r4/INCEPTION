#Create user
#l.9 cree la table de data
#l.10 cree un user 
#l.11 a qui on donne tous les droits = administrateur
#l.12 on change le mot de passe et les droits root pour limiter l'acces a l'admin
#l.13 rafraichir tout cela pour que MySQL le prenne en compte

cat << EOF > /tmp/init_db.sql
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

mysql -h localhost < /tmp/init_db.sql