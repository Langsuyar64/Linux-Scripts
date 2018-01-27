{\rtf1\ansi\ansicpg1252\cocoartf1561\cocoasubrtf100
{\fonttbl\f0\fswiss\fcharset0 Helvetica;\f1\fmodern\fcharset0 Courier;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;}
{\*\listtable{\list\listtemplateid1\listhybrid{\listlevel\levelnfc23\levelnfcn23\leveljc0\leveljcn0\levelfollow0\levelstartat1\levelspace360\levelindent0{\*\levelmarker \{disc\}}{\leveltext\leveltemplateid1\'01\uc0\u8226 ;}{\levelnumbers;}\fi-360\li720\lin720 }{\listname ;}\listid1}}
{\*\listoverridetable{\listoverride\listid1\listoverridecount0\ls1}}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 # Install LEMP Stack on Linux Server\
\
# Update repositories from Linux servers and install NGINX\
\pard\tx220\tx720\pardeftab720\li720\fi-720\sl280\partightenfactor0
\ls1\ilvl0
\f1 \cf2 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 sudo apt-get update && sudo apt-get install nginx\
\
# Install MYSQL Server\
sudo apt-get install mysql-server\
\
# Setup MySQL installation\
mysql_secure_installation\
\
# Install PHP 7.x\
sudo apt-get install php-fpm php-mysql\
\
# Open main php-fpm config file\
sudo nano /etc/php/7.0/fpm/php.ini\
\
# Change FASTCGI to be used on NGINX\
echo \cf2 \outl0\strokewidth0 Change to this cgi.fix_pathinfo=0\
\
# Restart PHP\
sudo systemctl restart php7.0-fpm\
\
#Configure Nginx to Use the PHP Processor\
echo add index.php to the line below root\
echo uncomment location ~ \\.php$ AND location ~/\\.ht\
echo check php7.0-fpm.sock version if is correct\
sudo nano /etc/nginx/sites-available/default\
\
#Test NGINX\
echo testing NGINX\'85\
sudo nginx -t\
echo reloading NGINX\'85\
sudo systemctl reload nginx\
\
#Create PHP test file at default location\
echo Creating PHP test file at default site location\
sudo bash -c 'cat >> /var/www/html/info.php << EOF\
<?php\
phpinfo();\
EOF'\
\
}
