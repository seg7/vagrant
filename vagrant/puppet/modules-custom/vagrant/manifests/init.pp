class vagrant() {

  lookup('puppet.includes').each |$value| { include "::vagrant::${value}" }

  exec { 'apt-update':
    command => "/usr/bin/apt-get update",
  }

  exec { 'apt-upgrade':
    command => "/usr/bin/apt-get --quiet --yes --fix-broken upgrade",
    logoutput => "on_failure",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/usr/local/sbin:/sbin",
    require => Exec['apt-update'],
  }

}
