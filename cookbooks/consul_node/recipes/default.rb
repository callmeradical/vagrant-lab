#
# Cookbook:: consul_node
# Recipe:: default
#

remote_file '/tmp/consul.zip' do
  source node.default['consul_url']
  owner 'vagrant'
  action :create_if_missing
end

execute 'extract_consul' do
  command 'unzip /tmp/consul.zip /usr/local/bin'
  not_if {::File.exist?('/usr/local/bin/consul')}
end