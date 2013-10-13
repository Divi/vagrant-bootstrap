VagrantBootstrap
================

A simple provisioning Vagrant bootstrap to be ready for PHP/MySQL development.

If you have using Symfony2, please see the branch named `symfony2`.

## Features :

- Apache 2 with rewrite mod and ready VHOST with "/var/www" moved to "/vagrant"
- PHP 5.x (last stable release, now 5.5.x. You can choose older stable version in bootstrap.sh, see PHP part)
- Preconfigured php.ini : show errors & set timezone
- PHP packages : php5-cli php5-mysql php5-curl php5-mcrypt php5-gd php-pear php5-xdebug php5-intl
- MariaDB (MySQL) with custom database and root remote access (no password)
- Some essential packages : build-essential git-core vim curl

## Forwarded ports :

- 22 (SSH) > 2222
- 80 (HTTP) > 8000
- 3306 (MySQL) > 33060

## Installation

### Install box

With Vagrant version >= 1.3.4
`vagrant up` and `vagrant provision` (if you have puppet or chef provision, you can run the command with the flag `--provision-with shell` to launch only shell provisioner)

or with Vagrant version < 1.3.4
`vagrant up`

### Stop box

`vagrant halt`

### Reload box (not install, only reboot after stopping)

With Vagrant version >= 1.3.4
`vagrant reload`

or with Vagrant version < 1.3.4
`vagrant reload --no-provision`

### Access to your web application

Simply go to your favorite browser and type this URL : `http://localhost:8000` !

## Bootstrap and box parameters

### Bootstrap parameters

You need to edit some custom parameters in the file ".vagrant_bootstrap/parameters.sh" :

Database parameters :
- `DATABASE_NAME` : your database name. If empty, no database will be created.
- `DATABASE_ROOT_HOST` : allowed host for the ROOT user. Put "localhost" (by default), for localhost access only (more secure in prod, for example), 10.0.2.2 for you host access only or "%" for remote access (usefull to access to the database from your remote database software).

PHP parameters :
- `PHP_TIMEZONE` : the PHP timezone (default: "UTC"). Check possible values here : http://php.net/manual/en/timezones.php

## Other stuff

Feel free to fork me or create issue for requesting the creation of a new feature !
