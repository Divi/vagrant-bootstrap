#!/usr/bin/env bash

# ----------------------------------------
# https://github.com/Divi/VagrantBootstrap
# ----------------------------------------

# PARAMETERS
# ----------

# Database
# --------
DATABASE_NAME="your_database_name"
# Replace "%" by "localhost" for local user only, 10.0.2.2 for host only or any IP address
DATABASE_ROOT_HOST="localhost"

# PHP
# ---
PHP_TIMEZONE="UTC"

# APPLICATION
# -----------
APPLICATION_NAME="appname"

# SAMBA
# -----
# DO NOT FORGET TO CONFIGURE YOUR ".samba_config/smb.conf" "valid users" property !
SAMBA_USER="vagrant"
SAMBA_PASSWORD="vagrant"

# PROJECT
# -------
PROJECT_GIT_REPOSITORY=""
PROJECT_GIT_BRANCH=""