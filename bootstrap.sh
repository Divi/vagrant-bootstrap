#!/usr/bin/env bash

# Update the box release repositories
# -----------------------------------
apt-get update

# VIM
# ---
apt-get install -y vim


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
echo "${VHOST}" > /etc/apache2/sites-enabled/000-default

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
apt-get install -y php5-cli
# Remove "/var/www" created by apache
rm -rf /var/www
# Symlink "/vagrant" to "/var/www"
ln -fs /vagrant/web /var/www
# MySQL driver
apt-get install -y php5-mysql
# cURL
apt-get install -y php5-curl
# MCrypt functions
apt-get install -y php5-mcrypt
# GD library
apt-get install -y php5-gd
# PEAR
apt-get install -y php-pear
# xDebug (TODO: need configs to enable it)
apt-get install -y php5-xdebug
# APC (only with PHP < 5.5.0, use the "opcache" if >= 5.5.0)
# apt-get install -y php-apc


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


# Git
# ---
apt-get install git-core