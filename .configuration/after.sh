#!/bin/sh

# If you would like to do some extra provisioning you may
# add any commands you wish to this file and they will
# be run after the Homestead machine is provisioned.

sudo sed -i.bak "s/; error_reporting/ error_reporting/g" /etc/php/7.0/fpm/php.ini
sudo sed -i.bak "s/;   Default Value: E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED/   Default Value: E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED/g" /etc/php/7.0/fpm/php.ini

sudo service nginx restart
