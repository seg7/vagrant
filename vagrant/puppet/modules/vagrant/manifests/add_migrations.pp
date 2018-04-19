class vagrant::add_migrations() {

  $basepath  = lookup('project.folder')

  exec { 'php artisan migrate':
    command => 'php artisan migrate',
    cwd => $basepath,
    path => '/usr/bin',
    require => [
      Class['::vagrant::add_php'],
      Class['::vagrant::add_apache'],
      Class['::vagrant::add_mariadb'],
    ],
  }

}
