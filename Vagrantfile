# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  # config.vm.box = "ubuntu/xenial64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.network "private_network", type: "dhcp"
  (1..4).each do |i|
    if i != 4 then
      config.vm.define "node-#{i}" do |node|
        node.vm.box = "ubuntu/xenial64"
      end
    else
      config.vm.define "workstation" do |node|
        node.vm.box = "ubuntu/xenial64"
      end
    end
  end

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

   config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #   # Customize the amount of memory on the VM:
     vb.memory = "512"
   end

   config.vm.provision "shell", inline: <<-SHELL
     apt-get update
     apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common
     curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
     add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"
     apt-get update
     apt-get install -y docker-ce docker-ce-cli containerd.io
     usermod -aG docker vagrant
   SHELL
end
