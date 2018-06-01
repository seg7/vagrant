class vagrant::add_migrations() {

  $basedir  = lookup('project.folder')

  exec { 'php artisan migrate':
    command => 'php artisan migrate',
    cwd     => $basedir,
    path    => '/bin:/usr/bin:/usr/local/bin',
    onlyif  => [
      "test -e $basedir/artisan"
    ],
    require => [
      Class['::vagrant::add_php'],
      Class['::vagrant::add_apache'],
      Class['::vagrant::add_mariadb'],
    ],
  }

}
