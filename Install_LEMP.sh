# Install LEMP Stack on Linux Server

# Update repositories from Linux servers and install NGINX
echo Installing NGINX Web Server...
sudo apt-get update && sudo apt-get install nginx -y

# Install MYSQL Server
echo installing MySQL Server...
sudo apt-get install mysql-server -y

# Setup MySQL installation
echo Setup MySQL installation...
mysql_secure_installation

# Install PHP 7.x
Installing PHP 7.x...
#sudo apt-get install php-fpm php-mysql -y
sudo apt-get install -y php7.0-common php7.0-fpm php7.0-cli php7.0-json php7.0-mysql php7.0-curl php7.0-intl php7.0-mcrypt php-pear php7.0-gd php7.0-zip php7.0-xml php7.0-mbstring

# Open main php-fpm config file
Editing main PHP-FPM config file
sudo nano /etc/php/7.0/fpm/php.ini

# Change FASTCGI to be used on NGINX
echo Change to this cgi.fix_pathinfo=0

# Restart PHP
Restarting PHP 7.x...
sudo systemctl restart php7.0-fpm

#Configure Nginx to Use the PHP Processor
echo add index.php to the line below root
echo uncomment location ~ \\.php$ AND location ~/\\.ht
echo check php7.0-fpm.sock version if is correct
sudo nano /etc/nginx/sites-available/default

#Test NGINX
echo testing NGINX...
sudo nginx -t
echo reloading NGINX...
sudo systemctl reload nginx

#Create PHP test file at default location
echo Creating PHP test file at default site location
sudo bash -c 'cat >> /var/www/html/info.php << EOF
<?php
phpinfo();
EOF'

#Install PHPMYADMIN
echo installing PHPMYADMIN...
sudo apt-get install phpmyadmin -y
sudo ln -s /usr/share/phpmyadmin /usr/share/nginx/html
sudo /etc/init.d/php7.0-fpm reload && sudo /etc/init.d/nginx reload
