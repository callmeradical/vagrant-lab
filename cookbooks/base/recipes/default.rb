#
# Cookbook:: base
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
apt_repository 'docker' do
  uri 'https://download.docker.com/linux/ubuntu'
  key 'https://download.docker.com/linux/ubuntu/gpg'
  arch 'amd64'
  components ['stable']
  action :add
end

packages = %w(
  curl
  unzip
  ca-certificates
  gnupg-agent
  software-properties-common
  apt-transport-https
  docker-ce
  docker-ce-cli
  containerd.io
  jq
  htop
)
# Copyright:: 2019, The Authors, All Rights Reserved.
packages.each do |pkg|
  package pkg.to_s do
    action :install
  end
end

file '/tmp/test' do
  action :create
end

group 'docker' do
  action :modify
  append true
  members 'vagrant'
end

private_address = node['ipaddress']
ruby_block 'find_private_ip_address' do
  block do
    require 'ipaddr'
    require 'socket'

    net = IPAddr.new(node['attributes']['subnet'])
    addr_info = Socket.ip_address_list

    addr_info.each do |info|
      begin
        if net.include?(IPAddr.new(info.ip_address))
          Chef::Log.warn("Found a match in #{info.ip_address}")
          private_address = info.ip_address
          break
        end
      rescue IPAddr::InvalidAddressError
        Chef::Log.warn("invalid address: #{info.ip_address} returned, skipping...")
        next
      end
    end
  end
end

template '/home/vagrant/.profile' do
  source 'profile.erb'
  owner 'vagrant'
  group 'vagrant'
  variables(nomad_env: lazy { "export NOMAD_ADDR=\"http://#{private_address}:4646\"" })
end
