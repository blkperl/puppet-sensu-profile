# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = 'puppetlabs/ubuntu-14.04-64-puppet'
  config.vm.provision :shell, inline: 'apt-get update'

  config.vm.define 'derp1' do |c|
    c.vm.hostname = 'derp1'
    c.vm.network :private_network, ip: '192.168.1.11'
    c.vm.network 'forwarded_port', guest: 3000, host: 3000
  end

  config.vm.define 'derp2' do |c|
    c.vm.hostname = 'derp2'
    c.vm.network :private_network, ip: '192.168.1.12'
    c.vm.network 'forwarded_port', guest: 3000, host: 3001
  end

  config.vm.define 'derpchild1' do |c|
    c.vm.hostname = 'derpchild1'
    c.vm.network :private_network, ip: '192.168.1.13'
  end
end
