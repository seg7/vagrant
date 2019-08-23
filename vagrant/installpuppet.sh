#!/usr/bin/env bash

PUPPETDIR="/opt/puppetlabs/bin"

export DEBIAN_FRONTEND=noninteractive

if [ ! -e "$PUPPETDIR/puppet" ]; then
    curl -O http://apt.puppetlabs.com/puppet5-release-trusty.deb
    dpkg -i puppet5-release-trusty.deb
    apt-get update
    apt-get upgrade
    apt-get -y install puppet-agent librarian-puppet
    rm -rf puppet5-release-trusty.deb
fi

PATH="$PATH:$PUPPETDIR"

cd /var/www/vagrant/puppet
librarian-puppet config tmp /tmp/ --local && librarian-puppet install
