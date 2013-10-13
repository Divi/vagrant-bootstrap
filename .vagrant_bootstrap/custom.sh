#!/bin/bash

# ----------------------------------------
# https://github.com/Divi/VagrantBootstrap
# ----------------------------------------

# CUSTOM BOOSTRAP FOR SYMFONY2 FOR WINDOWS USERS
# ----------------------------------------------

# Apply chmod for cache & logs
mkdir /dev/shm/$APPLICATION_NAME
chmod 777 -R /dev/shm/$APPLICATION_NAME

# Configure & clean shared folder
rm -rf /var/www
mkdir /var/www

# Fetching project
git clone $PROJECT_GIT_REPOSITORY /var/www/project
cd /var/www/project
if [ "$PROJECT_GIT_BRANCH" != "" ];
then
  # Checkout new branch
  git checkout $PROJECT_GIT_BRANCH
fi

# Composer stuff
curl -sS https://getcomposer.org/installer | php
php composer.phar install

# VHOST
cp /etc/apache2/sites-available/symfony2.conf.dist /etc/apache2/sites-available/000-default.conf
# Reload apache
service apache2 reload


# Add config for xDebug
echo "xdebug.max_nesting_level = 250" >> /etc/php5/apache2/php.ini

# Installing Samba
apt-get install -y samba
service smbd stop
# Configure Samba
rm -rf /etc/samba/smb.conf
cp /vagrant/.samba_config/smb.conf.dist /etc/samba/smb.conf
service smbd start
# Configure user
echo -ne "$SAMBA_PASSWORD\n$SAMBA_PASSWORD\n" | smbpasswd -L -a $SAMBA_USER
smbpasswd -L -e $SAMBA_USER

# Finally, give all rights
chmod 777 -R /var/www