class vagrant::add_mailhog() {

  class { 'mailhog':
    smtp_bind_addr_ip   => "127.0.0.1",
    smtp_bind_addr_port => "1025"
  }

  include mailhog

}
