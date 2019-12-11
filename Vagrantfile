# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  # config.vm.box = 'ubuntu/xenial64'

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.network 'private_network', type: 'dhcp'
  (1..4).each do |i|
    if i != 4
      config.vm.define "node-#{i}" do |node|
        node.vm.box = 'ubuntu/xenial64'
      end
    else
      config.vm.define 'workstation' do |node|
        node.vm.box = 'ubuntu/xenial64'
      end
    end
  end

  config.vm.provider 'virtualbox' do |vb|
    #   # Display the VirtualBox GUI when booting the machine
    #   vb.gui = true
    #   # Customize the amount of memory on the VM:
    vb.memory = '512'
  end

  config.vm.provision 'shell', inline: <<-SHELL
    apt-get update
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    add-apt-repository \
    'deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable'
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io
    usermod -aG docker vagrant
  SHELL
end
