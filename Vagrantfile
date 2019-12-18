# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  # config.vm.box = 'ubuntu/xenial64'

  Vagrant.configure("2") do |config|
	  config.vm.network "private_network", auto_config: true
	end

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  (1..4).each do |i|
    if i != 4
      config.vm.define "node-#{i}" do |node|
        node.vm.box = 'ubuntu/bionic64'
      end
    else
      config.vm.define 'workstation' do |node|
        node.vm.box = 'ubuntu/bionic64'
      end
    end
  end

  config.vm.provider 'virtualbox' do |vb|
    #   # Display the VirtualBox GUI when booting the machine
    #   vb.gui = true
    #   # Customize the amount of memory on the VM:
    vb.memory = '512'
  end

  config.vm.provision 'chef_solo' do |chef|
    chef.arguments = "--chef-license accept"
    chef.add_recipe "consul_node"
  end
end