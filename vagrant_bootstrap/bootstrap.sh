#!/usr/bin/env bash

# Include parameteres file
# ------------------------
source /vagrant/vagrant_bootstrap/parameters.sh

# Update the box release repositories
# -----------------------------------
apt-get update


# APACHE
# ------
apt-get install -y apache2
# Add ServerName to httpd.conf for localhost
echo "ServerName localhost" > /etc/apache2/httpd.conf
# Edit default apache alias
VHOST=$(cat <<EOF
<VirtualHost *:80>
  DocumentRoot "/var/www"
  ServerName localhost
  
  <Directory "/var/www">
    AllowOverride None
  </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

# Enable "mod_rewrite"
a2enmod rewrite
# Finally, restart apache
service apache2 restart


# PHP 5.x (last official release)
# See: https://launchpad.net/~ondrej/+archive/php5
# ------------------------------------------------
apt-get install -y libapache2-mod-php5
# Install "add-apt-repository" binaries
apt-get install -y python-software-properties
# Install PHP 5.x
# Use "ppa:ondrej/php5-oldstable" for old and stable release
add-apt-repository ppa:ondrej/php5
# Update repositories
apt-get update

# PHP tools
apt-get install -y php5-cli php5-mysql php5-curl php5-mcrypt php5-gd php-pear php5-xdebug php5-intl
# APC (only with PHP < 5.5.0, use the "opcache" if >= 5.5.0)
# apt-get install -y php-apc
# Remove "/var/www" created by apache
rm -rf /var/www
# Symlink "/vagrant" to "/var/www"
ln -fs /vagrant/web /var/www


# MySQL (MariaDB)
# See: http://doc.ubuntu-fr.org/mariadb
# -------------------------------------
# Install new repository
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 1BB943DB
echo deb http://ftp.igh.cnrs.fr/pub/mariadb//repo/5.5/ubuntu $(lsb_release -sc) main | tee /etc/apt/sources.list.d/MariaDB.list 
# Update repositories
apt-get update
# Ignore all prompt questions
export DEBIAN_FRONTEND=noninteractive
# Finally, install MariaDB
apt-get install -y mariadb-server


# Essential packages
# ------------------
apt-get install -y build-essential git-core vim curl


# Configure MySQL database and user
# ---------------------------------
# Edit my.cnf to unbind localhost
if [ "$DATABASE_HOST" != "localhost" ];
then
  sed "s/bind-address\([[:space:]]*\)=\([[:space:]]*\)127.0.0.1/bind-address\1=\20.0.0.0/g" /etc/mysql/my.cnf > /etc/mysql/my.cnf.tmp
  mv /etc/mysql/my.cnf.tmp /etc/mysql/my.cnf
  # Restart MySQL to reload edited configuration file
  service mysql restart
fi
# Create user & database
echo "CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME}" | mysql
echo "CREATE USER '${DATABASE_USER}'@'${DATABASE_HOST}' IDENTIFIED BY '${DATABASE_PASSWORD}'" | mysql
echo "GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${DATABASE_USER}'@'${DATABASE_HOST}' IDENTIFIED BY '${DATABASE_PASSWORD}'" | mysql
