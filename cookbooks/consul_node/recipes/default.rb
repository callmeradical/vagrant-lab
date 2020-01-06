#
# Cookbook:: consul_node
# Recipe:: default
#

group 'consul'

user 'consul' do
  group 'consul'
end
package 'unzip' do
  action :install
end

remote_file "#{Chef::Config[:file_cache_path]}/consul.zip" do
  source node.default['attributes']['consul_url']
  owner 'consul'
  action :create_if_missing
end

execute 'extract_consul' do
  command "unzip #{Chef::Config[:file_cache_path]}/consul.zip -d /usr/local/bin/"
  not_if { ::File.exist?('/usr/local/bin/consul') }
end

directory '/opt/consul.d' do
  owner 'consul'
  group 'consul'
  action :create
end

directory '/opt/consul' do
  owner 'consul'
  group 'consul'
  action :create
end

template '/etc/systemd/system/consul.service' do
  source 'consul_systemd.erb'
  owner 'root'
  group 'root'
  mode '0755'
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

template '/opt/consul.d/consul.hcl' do
  source 'consul.hcl.erb'
  owner 'consul'
  group 'consul'
  mode '0755'
  variables(ip_to_advertise: lazy { ip_to_advertise.to_s })
  action :create
end

template '/opt/consul.d/server.hcl' do
  source 'server.hcl.erb'
  owner 'consul'
  group 'consul'
  mode '0755'
  variables(servers: node['attributes']['server_count'])
  only_if { node['attributes']['server'] }
end

service 'consul' do
  action :start
end
