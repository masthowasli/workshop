#!/bin/sh
#
# this installs apache2, mysql, phpmyadmin and php5 packages
# as well as ant, mc, git
# it enables ssl access and creates a mysql database with user dev : dev
#

# we are running non interactive
export DEBIAN_FRONTEND=noninteractive

# copy files and fix perms
cp -R /vagrant/.provision/files/* /
chown -R vagrant:vagrant /home/vagrant/.ssh

# update apt package index
apt-get update

# install apache
apt-get -y install apache2-mpm-itk
a2enmod ssl
a2enmod rewrite
a2dissite 000-default
a2ensite vagrant

# install mysql
apt-get -y install mysql-server
mysql -uroot -e "CREATE DATABASE IF NOT EXISTS lwfm CHARACTER SET utf8;"
mysql -uroot -e "GRANT ALL PRIVILEGES ON lwfm.* TO 'dev'@'%' identified by 'dev'; FLUSH PRIVILEGES;"

# install mailer
apt-get install -y exim4

# install php
apt-get -y install php5 php5-cli php5-gd php5-mcrypt php5-curl php-apc php5-xdebug

# install rest
apt-get -y install ant curl mc git-core phpmyadmin
ln -sf /etc/phpmyadmin/apache.conf /etc/apache2/conf.d/phpmyadmin.conf

# services restart
service apache2 restart
