class vagrant::add_nodejs() {

  class { 'nodejs':
    repo_url_suffix => '9.x',
  }

}
