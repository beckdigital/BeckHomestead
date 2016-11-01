#!/bin/sh

# If you would like to do some extra provisioning you may
# add any commands you wish to this file and they will
# be run after the Homestead machine is provisioned.

echo 'echo "error_reporting\n   Default Value: E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED" >> /etc/php/7.0/fpm/php.ini' | sudo -s

sudo service nginx restart
