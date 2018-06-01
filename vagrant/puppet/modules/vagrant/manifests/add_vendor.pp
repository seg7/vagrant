class vagrant::add_vendor() {

  $basedir = lookup('project.folder')

  exec { 'composer install':
    command     => 'composer install',
    cwd         => $basedir,
    path        => '/bin:/usr/bin:/usr/local/bin',
    environment => ['HOME=/root'],
    onlyif      => [
      "test ! -d $basedir/vendor",
      "test -e $basedir/composer.json"
    ],
    timeout     => 0,
    require     => [
      Class['::vagrant::add_php'],
      Class['::vagrant::add_apache'],
      Class['::vagrant::add_mariadb'],
    ],
  }

}
