# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

require 'yaml'
dir = File.dirname(File.expand_path(__FILE__))
data = YAML.load_file("#{dir}/vagrant/config.yaml")

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "#{data['vm']['box']}"
  config.vm.box_check_update = true
  #config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network :private_network, ip: "#{data['network']['private_network']}"
  config.ssh.forward_agent = true
  config.vm.hostname = "#{data['network']['hostname']}"
  config.vm.synced_folder '.', "#{data['project']['folder']}",
    owner: 'www-data', group: 'www-data'

  if Vagrant.has_plugin?("vagrant-hostsupdater")
    server_aliases = Array.new()
    data['network']['aliases'].each do |server_alias|
      server_aliases.push(server_alias)
    end
    config.hostsupdater.aliases = server_aliases
    config.hostsupdater.remove_on_suspend = true
  end

  config.vm.provider "virtualbox" do |v|
    v.name = "#{data['network']['hostname']}"
    v.memory = "#{data['vm']['memory']}"
    v.cpus = "#{data['vm']['cpus']}"
  end

  config.vm.provision :"shell", path: "vagrant/installpuppet.sh", env: {"BASEDIR" => "#{data['project']['folder']}"}
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "vagrant/puppet/manifests"
    puppet.module_path = ["vagrant/puppet/modules","vagrant/puppet/modules-custom"]
    puppet.hiera_config_path = "vagrant/puppet/hierra.yaml"
    puppet.options = ["#{data['puppet']['options']}"]
  end

  if Vagrant.has_plugin?("vagrant-reload")
    config.vm.provision :reload
  end

end
