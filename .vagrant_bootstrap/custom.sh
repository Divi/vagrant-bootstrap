#!/bin/bash

# ----------------------------------------
# https://github.com/Divi/VagrantBootstrap
# ----------------------------------------

# CUSTOM BOOSTRAP FOR SYMFONY2
# ----------------------------

# VHOST
cp /etc/apache2/sites-available/symfony2.conf.dist /etc/apache2/sites-available/000-default.conf
# Reload apache
service apache2 reload

# Apply chmod for cache & logs
mkdir /dev/shm/$APPLICATION_NAME
chmod 777 -R /dev/shm/$APPLICATION_NAME

# Add config for xDebug
echo "xdebug.max_nesting_level = 250" >> /etc/php5/apache2/php.ini

# Composer stuff
cd /var/www
curl -sS https://getcomposer.org/installer | php
php composer.phar install