class vagrant::add_motd() {

  class { 'motd':
    template => '/var/www/vagrant/puppet/modules-custom/vagrant/templates/motd/motd.erb',
  }

}
