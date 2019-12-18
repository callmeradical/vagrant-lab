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
)
# Copyright:: 2019, The Authors, All Rights Reserved.
packages.each do |pkg|
  package pkg.to_s do
    action :install
  end
end

group 'docker' do
  action :modify
  append true
  members 'vagrant'
end

