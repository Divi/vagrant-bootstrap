Vagrant for Symfony2
====================

A simple provisioning Vagrant bootstrap to be ready for PHP/MySQL development.
This is a Symfony2 bootstrap for Windows users only !

## Be careful :

Vagrant on Windows with Symfony 2 is very slow. However, Samba can solve this issue, but we must avoid a problem : the project won't be on the HOST, but only on the GUEST, provided by a GIT repository and shared with Samba. So, please remember this.

## Step 1 :

Add to your `web/app_dev.php` (line ~14) & `web/config.php` (line ~9) the IP exclusion `10.0.2.2` because your host is not the localhost.

## Step 2 :

You must to mount the driver, simply go to the computer folder, and "Connect a network driver" with this address : `\\192.168.100.10\shared`.
Do not forget to unmount the driver on halt (right click and unmount).

If you want to make an automatic script bash :
- Mount : `net use \\192.168.100.10\shared vagrantpassword /USER:vagrantuser && pushd \\192.168.100.10\shared` (replace "vagrantuser" by your Samba user and "vagrantpass" by your Samba password)
- Unmount : `net use Z: /delete` (the `Z` letter might be different for you)

## Step 3 :

Only if you have performance issue, please edit your AppKernel.php, replace "appname" with your application name (it must be the same of the `APPLICATION_NAME` parameter in the file "parameters.sh" !). For more information about this fix, please read : http://www.whitewashing.de/2013/08/19/speedup_symfony2_on_vagrant_boxes.html
```php
<?php

class AppKernel extends Kernel
{
    // ...

    public function getCacheDir()
    {
        if (in_array($this->environment, array('dev', 'test'))) {
            return '/dev/shm/appname/cache/' .  $this->environment;
        }

        return parent::getCacheDir();
    }

    public function getLogDir()
    {
        if (in_array($this->environment, array('dev', 'test'))) {
            return '/dev/shm/appname/logs';
        }

        return parent::getLogDir();
    }
}
```

That's all !

## Features :

- Apache 2 with rewrite mod and ready VHOST
- PHP 5.x (last stable release, now 5.5.x. You can choose older stable version in bootstrap.sh, see PHP part)
- Preconfigured php.ini : show errors & set timezone & ready to use for Symfony 2
- PHP packages : php5-cli php5-mysql php5-curl php5-mcrypt php5-gd php-pear php5-xdebug php5-intl
- MariaDB (MySQL) with custom database and root remote access (no password)
- Some essential packages : build-essential git-core vim curl
- Samba shared folder, with no development slow

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

Application parameters :
- `APPLICATION_NAME` : your application name, please see the "Step 1".

Samba parameters :
- `SAMBA_USER` : your samba user.
- `SAMBA_PASSWORD` : your samba password.
They will used when you will connect the virtual driver.

Project parameters :
- `PROJECT_GIT_REPOSITORY` : your GIT project repository
- `PROJECT_GIT_BRANCH` : your GIT project repository branch, let empty for "master".

## Other stuff

Feel free to fork me or create issue for requesting the creation of a new feature !

## Bonus

How to install RabbitMQ ready to use for Symfony 2 ? : https://gist.github.com/Divi/7469991
