class vagrant::add_mariadb() {

  $username = lookup('puppet.add_mariadb.username') ? {
    undef   => inline_template("<%= `tr -cd A-Z0-9  < /dev/urandom | fold -w15 | head -n1` -%>").strip,
    default => lookup('puppet.add_mariadb.username')
  }
  $password = lookup('puppet.add_mariadb.password') ? {
    undef   => inline_template("<%= `tr -cd A-Z0-9  < /dev/urandom | fold -w15 | head -n1` -%>").strip,
    default => lookup('puppet.add_mariadb.password')
  }

  include apt

  #apt::conf { 'unauth':
  #  priority => 99,
  #  content  => 'APT::Get::AllowUnauthenticated 1;'
  #}

  apt::source { 'mariadb':
    location => 'http://mirrors.up.pt/pub/mariadb/repo/10.2/ubuntu',
    release  => $::lsbdistcodename,
    repos    => 'main',
    key      => {
      id     => '0xF1656F24C74CD1D8',
      server => 'hkp://keyserver.ubuntu.com:80',
    },
    include => {
      src   => false,
      deb   => true,
    },
  }



  class {'::mysql::server':
    package_name       => 'mariadb-server',
    #package_ensure    => '10.1.14+maria-1~trusty',
    service_name       => 'mysql',
    #root_password     => 'e5z@gdQtSdHf',
    create_root_user   => false,
    create_root_my_cnf => false,
    users => {
      "$username@%" => {
        ensure                   => 'present',
        max_connections_per_hour => '0',
        max_queries_per_hour     => '0',
        max_updates_per_hour     => '0',
        max_user_connections     => '0',
        password_hash            => mysql_password("$password"),
        tls_options              => ['NONE'],
      },
    },

    grants => {
      "$username@%/*.*" => {
        ensure     => 'present',
        options    => ['GRANT'],
        privileges => ['ALL'],
        table      => '*.*',
        user       => "$username@%",
      },
    },
    override_options => {
      client => {
        'default-character-set' => 'utf8',
      },
      mysql => {
        'default-character-set' => 'utf8',
      },
      mysqld => {
        'bind-address' => '0.0.0.0',
        'log-error' => '/var/log/mysql/mariadb.log',
        'pid-file'  => '/var/run/mysqld/mysqld.pid',
        'collation-server' => 'utf8_unicode_ci',
        'init-connect' => "'SET NAMES utf8'",
        'character-set-server' => 'utf8',
      },
      mysqld_safe => {
        'log-error' => '/var/log/mysql/mariadb.log',
      },
    },
    databases => lookup('puppet.add_mariadb.databases')
  }

  # Dependency management. Only use that part if you are installing the repository
  # as shown in the Preliminary step of this example.
  Apt::Source['mariadb'] ~>
  Class['apt::update'] ->
  Class['::mysql::server']

}
