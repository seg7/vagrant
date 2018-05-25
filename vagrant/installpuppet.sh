#!/usr/bin/env bash

PUPPETDIR="/opt/puppetlabs/bin"

if [ ! -e "$PUPPETDIR/puppet" ]; then
    curl -O http://apt.puppetlabs.com/puppet5-release-trusty.deb
    dpkg -i puppet5-release-trusty.deb
    apt-get update
    apt-get install puppet-agent
    rm -rf puppet5-release-trusty.deb
fi
PATH="$PATH:$PUPPETDIR"
if [[ ! -d "$BASEDIR/vagrant/puppet/modules/php" ]]; then
    puppet module install puppet-php --modulepath "$BASEDIR/vagrant/puppet/modules"        # --version 5.3.0
fi
if [[ ! -d "$BASEDIR/vagrant/puppet/modules/apache" ]]; then
    puppet module install puppetlabs-apache --modulepath "$BASEDIR/vagrant/puppet/modules" # --version 3.1.0
fi
if [[ ! -d "$BASEDIR/vagrant/puppet/modules/mysql" ]]; then
    puppet module install puppetlabs-mysql --modulepath "$BASEDIR/vagrant/puppet/modules"  # --version 5.3.0
fi
if [[ ! -d "$BASEDIR/vagrant/puppet/modules/nodejs" ]]; then
    puppet module install puppet-nodejs --modulepath "$BASEDIR/vagrant/puppet/modules"     # --version 5.0.0
fi
if [[ ! -d "$BASEDIR/vagrant/puppet/modules/ohmyzsh" ]]; then
    puppet module install zanloy-ohmyzsh --modulepath "$BASEDIR/vagrant/puppet/modules"    # --version 1.0.3
fi
if [[ ! -d "$BASEDIR/vagrant/puppet/modules/mailhog" ]]; then
    puppet module install ftaeger-mailhog --modulepath "$BASEDIR/vagrant/puppet/modules"   # --version 1.1.0
fi