Run these commands to start the webserver, I'm using a fresh install of Debian 10:

Default mysql password is blank.
The second time you are asked, it is "pass".

```
apt update && apt upgrade -y
apt install apache2 mariadb-server php libapache2-mod-php php-mysql git -y
mysql -u root -p -Bse "ALTER USER 'root'@'localhost' IDENTIFIED BY 'pass';FLUSH PRIVILEGES;"
mysql -u root -p -Bse "CREATE DATABASE crypto;GRANT ALL ON crypto.* to 'dbuser'@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION;FLUSH PRIVILEGES;"
cd /
git clone https://github.com/lmburns/cryptotax
```

Setting up the webserver to route to the proper folder
```
sed -i -e 's#<Directory /var/www/>#<Directory /cryptotax/PHP/>#' /etc/apache2/apache2.conf
sed -i -e 's#DocumentRoot /var/www/html#DocumentRoot /cryptotax/PHP#' /etc/apache2/sites-available/000-default.conf
service apache2 restart

```


This allows a user to upload files to the folder, I think 777 can be updated
```
cd /cryptotax/PHP
mkdir uploads
chmod 777 /cryptotax/PHP/uploads
```
