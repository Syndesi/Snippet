#!/bin/bash
# Installation script for linux servers
# start it: sudo bash linuxServerSetup.sh


while [[ -z "$user" ]]
do
  read -p "$(echo -e '  Username: ')" user
done
while [[ "$mysql_password" != "$mysql_password_2" ]] || [[ -z "$mysql_password" ]]
do
  read -p "$(echo -e '  MySQL-Password: \n\b ')" -s mysql_password
  read -p "$(echo -e '  MySQL-Password (verify): \n\b ')" -s mysql_password_2
done
echo "  Passwords are matching"


# Updating the system
  echo "Update the System..."
  sudo apt-get -y -qq update
  echo "Upgrade the System..."
  sudo apt-get -y -qq upgrade

# Apache
  echo "Installing Apache..."
  sudo apt-get -y -qq install apache2 libapache2-mod-php7.0
  # add r/w-access to the given user
  sudo groupadd www
  sudo adduser $user www
  sudo chgrp www /var/www/html
  sudo chmod g+w /var/www/html
# PHP 7.0
  echo "Installing PHP..."
  sudo apt-get -y -qq install php7.0-mysql php7.0-curl php7.0-sqlite3 php7.0-cli

# MySQL
  echo "Installing MySQL-Server..."
  sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $mysql_password"
  sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $mysql_password"
  sudo apt-get -y -qq install mysql-server

# FTP-Server
  echo "Installing FTP-Server (vsftpd)..."
  sudo apt-get -y -qq install vsftpd
  # enable ssl
  sed -i "s/\(^ssl_enable *= *\).*/\1TRUE/" /etc/vsftpd.conf
  # change the banner
  sed -i 's/#ftpd_banner/ftpd_banner/g' /etc/vsftpd.conf
  sed -i "s/\(^ftpd_banner *= *\).*/\1Powered by Syndesi/" /etc/vsftpd.conf
  sudo service vsftpd restart

# some other programs
  echo "Installing Git..."
  sudo apt-get -y -qq install git

echo ""
echo "Everything is installed"