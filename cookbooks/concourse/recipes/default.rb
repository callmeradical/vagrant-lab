#
# Cookbook:: concourse
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.




user 'concourse' do
  action :create
end

group 'concourse' do
  members ['concourse']
  action :create
end

remote_file "#{Chef::Config[:file_cache_path]}/concourse.tar.gz" do
  source node.default['attributes']['concourse_url']
  owner 'concourse'
  action :create_if_missing
end