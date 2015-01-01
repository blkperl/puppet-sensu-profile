# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.hostmanager.enabled = true

  config.vm.box = 'puppetlabs/ubuntu-14.04-64-puppet'

  config.vm.define 'sensu1' do |c|
    c.vm.hostname = 'sensu1'
    c.vm.network :private_network, ip: '192.168.1.11'
    c.vm.network 'forwarded_port', guest: 3000, host: 3000
  end

  config.vm.define 'sensu2' do |c|
    c.vm.hostname = 'sensu2'
    c.vm.network :private_network, ip: '192.168.1.12'
    c.vm.network 'forwarded_port', guest: 3000, host: 3001
  end

  config.vm.define 'stats1' do |c|
    c.vm.hostname = 'stats1'
    c.vm.network :private_network, ip: '192.168.1.13'
  end

  config.vm.provision :shell, inline: 'apt-get update'
  config.vm.provision :shell, inline: 'apt-get install puppet -y'

  # r10k plugin to deploy puppet modules
  config.r10k.puppet_dir = "puppet"
  config.r10k.puppetfile_path = "puppet/Puppetfile"
  config.r10k.module_path = "puppet/vendor"

  config.vm.provision :puppet do |puppet|
    puppet.hiera_config_path = 'puppet/hiera.yaml'
    puppet.manifest_file     = 'site.pp'
    puppet.manifests_path    = 'puppet/manifests'
    puppet.module_path       = ['puppet/modules', 'puppet/vendor']
    puppet.options           = '--verbose'
  end
end
