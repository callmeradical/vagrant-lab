# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  (1..4).each do |i|
    case i
    when 1
      config.vm.define 'consul_leader' do |node|
        node.vm.box = 'ubuntu/bionic64'
        node.vm.hostname = "node-#{i}"
        node.vm.network 'private_network', ip: '192.168.95.3'
        config.vm.provision 'chef_solo' do |chef|
          chef.roles_path = 'roles'
          chef.arguments = '--chef-license accept'
          chef.add_role 'consul_server_leader'
        end
      end
    when 2..3
      config.vm.define "node-#{i}" do |node|
        node.vm.box = 'ubuntu/bionic64'
        node.vm.hostname = "node-#{i}"
        node.vm.network 'private_network', ip: "192.168.95.#{i + 2}"
        config.vm.provision 'chef_solo' do |chef|
          chef.roles_path = 'roles'
          chef.arguments = '--chef-license accept'
          chef.add_role 'consul_server'
        end
      end
    when 4
      config.vm.define 'workstation' do |node|
        node.vm.box = 'ubuntu/bionic64'
        node.vm.hostname = "node-#{i}"
        node.vm.network 'private_network', ip: '192.168.95.7'
        config.vm.provision 'chef_solo' do |chef|
          chef.roles_path = 'roles'
          chef.arguments = '--chef-license accept'
          chef.add_role 'workstation'
        end
      end
    end
  end

  config.vm.provider 'virtualbox' do |vb|
    vb.memory = '512'
  end
end
