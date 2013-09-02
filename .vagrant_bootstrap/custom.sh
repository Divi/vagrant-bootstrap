#!/bin/bash

# ----------------------------------------
# https://github.com/Divi/VagrantBootstrap
# ----------------------------------------

# CUSTOM BOOSTRAP FOR YOUR PROJECT
# --------------------------------

# Remove "/var/www" created by apache
rm -rf /var/www
# Symlink "/vagrant" to "/var/www"
ln -fs /vagrant /var/www