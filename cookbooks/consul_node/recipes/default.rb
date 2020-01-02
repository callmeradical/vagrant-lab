#
# Cookbook:: consul_node
# Recipe:: default
#

remote_file Chef::Config[:file_cache_path].to_s do
  source node.default['consul_url']
  owner 'vagrant'
  action :create_if_missing
end

execute 'extract_consul' do
  command "unzip #{Chef::Config[:file_cache_path]}/consul.zip /usr/local/bin"
  not_if { ::File.exist?('/usr/local/bin/consul') }
end
