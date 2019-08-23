class vagrant::add_apache() {

  $hostname = lookup('network.hostname')
  $docroot  = lookup('puppet.add_apache.docroot')

  class { 'apache':
    default_vhost => false,
    #mpm_module => 'prefork',
  }->
  exec { 'rm -rf /var/www/html':
    command => 'rm -rf /var/www/html',
    path    => '/bin:/usr/bin:/usr/local/bin',
  }

  class { 'apache::mod::rewrite': }
  class { 'apache::mod::actions': }
  #class { 'apache::mod_proxy_fcgi': }
  #class { 'apache::mod::php': }

  apache::fastcgi::server { 'php':
    host       => '127.0.0.1:9000',
    timeout    => 600,
    flush      => false,
    faux_path  => '/var/www/php.fcgi',
    fcgi_alias => '/php.fcgi',
    file_type  => 'application/x-httpd-php'
  }

  apache::vhost { $hostname:
    vhost_name      => '*',
    port    => '80',
    allow_encoded_slashes => 'on',
    docroot => $docroot,
    docroot_owner => 'www-data',
    docroot_group => 'www-data',
    custom_fragment => 'AddType application/x-httpd-php .php',
    directories => [
      { path           => $docroot,
        options        => ['+Indexes','+FollowSymLinks'],
        directoryindex => 'index.php index.html',
        order          => 'Allow,Deny',
        allow_from     => 'all',
        allow_override => ['All'],
      },
    ],
    setenv => ['APPLICATION_ENV "development"'],
  }

}
