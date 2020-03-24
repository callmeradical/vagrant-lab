# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  (0..6).each do |i|
    case i
    when 0
      config.vm.define "node-#{i}" do |node|
        node.vm.box = 'ubuntu/bionic64'
        node.vm.hostname = "node-#{i}"
        node.vm.network 'private_network', ip: '192.168.95.3'
        node.vm.provision 'chef_solo' do |chef|
          chef.roles_path = 'roles'
          chef.arguments = '--chef-license accept'
          chef.add_role 'consul_server_leader'
        end
      end
    when 1..2
      config.vm.define "node-#{i}" do |node|
        node.vm.box = 'ubuntu/bionic64'
        node.vm.hostname = "node-#{i}"
        node.vm.network 'private_network', ip: "192.168.95.#{i + 3}"
        node.vm.provision 'chef_solo' do |chef|
          chef.roles_path = 'roles'
          chef.arguments = '--chef-license accept'
          chef.add_role 'consul_server'
        end
      end
    when 3..6
      config.vm.define "node-#{i}" do |node|
        node.vm.box = 'ubuntu/bionic64'
        node.vm.hostname = "node-#{i}"
        node.vm.network 'private_network', ip: "192.168.95.#{i + 3}"
        node.vm.provision 'chef_solo' do |chef|
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
