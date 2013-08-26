# CUSTOM BOOSTRAP FOR SYMFONY2
# ----------------------------

# Delete symlink /var/www and create new folder
rm -rf /var/www
mkdir /var/www

# VHOST
VHOST=$(cat <<EOF
<VirtualHost *:80>
	DocumentRoot "/var/www/web"
	DirectoryIndex app_dev.php
	ServerName localhost
	
	<Directory "/var/www/web">
		AllowOverride None
		Allow from All
		<IfModule mod_rewrite.c>
			RewriteEngine On
			
			RewriteCond %{REQUEST_URI}::$1 ^(/.+)/(.*)::\2$
			RewriteRule ^(.*) - [E=BASE:%1]
			
			RewriteCond %{ENV:REDIRECT_STATUS} ^$
			RewriteRule ^app_dev\.php(/(.*)|$) %{ENV:BASE}/$2 [R=301,L]
			
			RewriteCond %{REQUEST_FILENAME} -f
			RewriteRule .? - [L]
			
			RewriteRule .? %{ENV:BASE}/app_dev.php [L]
		</IfModule>
	</Directory>
	
	ErrorLog "/var/www/app/logs/apache_app_errors.log"
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf
# Reload apache
service apache2 reload
# Clear www folder
rm -rf /var/www/index.html

# Add required files
cp /vagrant/composer.json /var/www
cp /vagrant/composer.lock /var/www
cp /vagrant/composer.phar /var/www

# Run composer install
cd /var/www
php composer.phar install

# Apply chmod for cache & logs
chmod 777 -R /dev/shm/$APPLICATION_NAME