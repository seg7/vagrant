class vagrant::add_ohmyzsh() {

  ohmyzsh::install {
    ['root', 'vagrant']: set_sh => true
  }

  ohmyzsh::theme {
    ['root', 'vagrant']: theme => 'agnoster'
  }

  ohmyzsh::plugins {
    ['root', 'vagrant']: plugins => ['git', 'sudo']
  }->
  exec { 'echo "cd /var/www" >> /home/vagrant/.zprofile':
    command => 'echo "cd /var/www" >> /home/vagrant/.zprofile',
    path    => '/bin:/usr/bin:/usr/local/bin',
    user    => 'vagrant',
  }

}
