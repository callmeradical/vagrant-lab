#
# Cookbook:: nomad_node
# Recipe:: default
#

user 'nomad'

group 'nomad' do
  members ['nomad']
end

package 'unzip' do
  action :install
end

ip_to_advertise = node['ipaddress']
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
          ip_to_advertise = info.ip_address
          break
        end
      rescue IPAddr::InvalidAddressError
        Chef::Log.warn("invalid address: #{info.ip_address} returned, skipping...")
        next
      end
    end
  end
end

remote_file "#{Chef::Config[:file_cache_path]}/nomad.zip" do
  source node.default['attributes']['nomad_url']
  owner 'nomad'
  action :create_if_missing
end

execute 'install nomad' do
  command "unzip -u #{Chef::Config[:file_cache_path]}/nomad.zip -d /usr/local/bin/"
  action :run
end

directory '/opt/nomad.d' do
  owner 'nomad'
  group 'nomad'
  mode '0700'
end

directory '/opt/nomad' do
  owner 'nomad'
  group 'nomad'
  mode '0700'
end

template '/opt/nomad.d/server.hcl' do
  source 'server.hcl.erb'
  owner 'nomad'
  group 'nomad'
  mode '0600'
  only_if { node.default['attributes']['server'] }
end

template '/opt/nomad.d/nomad.hcl' do
  source 'nomad.hcl.erb'
  owner 'nomad'
  group 'nomad'
  mode '0600'
  variables(ip_to_advertise: lazy { ip_to_advertise.to_s })
end

template '/etc/systemd/system/nomad.service' do
  source 'nomad.service.erb'
  mode '0600'
end

service 'nomad' do
  action :start
end
