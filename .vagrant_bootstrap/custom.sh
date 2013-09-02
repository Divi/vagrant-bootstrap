#!/bin/bash

# ----------------------------------------
# https://github.com/Divi/VagrantBootstrap
# ----------------------------------------

# CUSTOM BOOSTRAP FOR SYMFONY2
# ----------------------------

# Delete symlink /var/www and create folder
rm -rf /var/www
ln -fs /home/project/web /var/www

# VHOST
cp /etc/apache2/sites-available/symfony2.conf.dist /etc/apache2/sites-available/000-default.conf
# Reload apache
service apache2 reload

# Run composer install
cd /home/project
php composer.phar install

# Apply chmod for cache & logs
mkdir /dev/shm/$APPLICATION_NAME
chmod 777 -R /dev/shm/$APPLICATION_NAME
