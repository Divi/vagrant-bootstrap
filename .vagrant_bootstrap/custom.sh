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
