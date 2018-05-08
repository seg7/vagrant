class vagrant::add_php() {

  $version = lookup('puppet.add_php.version')

  class { '::php::globals':
    php_version => $version,
    config_root => "/etc/php/$version",
  }->
  class { '::php':
    ensure       => "${version}*",
    manage_repos => true,
    package_prefix => "php${version}-",
    fpm          => true,
    settings     => {
      'PHP/display_errors'       => 'On',
      'PHP/error_reporting'      => 'E_ALL & ~E_USER_DEPRECATED',
      'Date/date.timezone'       => 'Europe/Lisbon',
    },
    extensions => {
      bcmath => {
        provider => 'apt',
        package_prefix  => "php${version}-",
      },
      bz2 => {
        provider => 'apt',
        package_prefix  => "php${version}-",
      },
      curl => {
        provider => 'apt',
        package_prefix  => "php${version}-",
      },
      gd => {
        provider => 'apt',
        package_prefix  => "php${version}-",
      },
      intl => {
        provider => 'apt',
        package_prefix  => "php${version}-",
      },
      ldap => {
        provider => 'apt',
        package_prefix  => "php${version}-",
      },
      mbstring => {
        provider => 'apt',
        package_prefix  => "php${version}-",
      },
      mcrypt => {
        provider => 'apt',
        package_prefix  => "php${version}-",
      },
      mysql => {
        provider => 'apt',
        package_prefix  => "php${version}-",
        so_name => 'mysqli',
      },
      sqlite3 => {
        provider => 'apt',
        package_prefix  => "php${version}-",
      },
      ssh2 => {
        provider => 'apt',
        package_prefix  => "php-",
      },
      xdebug => {
        provider => 'apt',
        package_prefix  => "php${version}-",
        zend => true,
        settings => {
          'xdebug.remote_enable' => 'On',
          'xdebug.remote_host'   => '192.168.7.1',
          'xdebug.remote_port'   => '9007',
        },
      },
      zip => {
        provider => 'apt',
        package_prefix  => "php${version}-",
      },
    },
  }

}
