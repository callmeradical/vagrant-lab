#
# Cookbook:: consul_node
# Spec:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'consul_node::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'
    automatic_attributes['ipaddress'] = '8.8.8.8'

    it 'creates the consul user and group' do
      expect(chef_run).to create_group('consul')
      expect(chef_run).to create_user('consul').with(
        group: 'consul'
      )
    end
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'downloads consul from hashicorp' do
      expect(chef_run).to create_remote_file_if_missing("#{Chef::Config[:file_cache_path]}/consul.zip")
      expect(chef_run).to run_execute('extract_consul')
    end

    it 'creates a configuration for consul server' do
      expect(chef_run).to create_directory('/opt/consul')
      expect(chef_run).to create_directory('/opt/consul.d')
      expect(chef_run).to create_template('/opt/consul.d/server.hcl').with(
        source: 'server.hcl.erb',
        owner: 'consul',
        group: 'consul',
        mode: '0755'
      )
    end

    it 'use its own ipaddress as the join ip' do
      allow(IPAddr).to receive(:new)
      expect(chef_run).to create_template('/opt/consul.d/consul.hcl').with(
        source: 'consul.hcl.erb',
        owner: 'consul',
        group: 'consul',
        mode: '0755'
      )
      expect(chef_run).to run_ruby_block('find_private_ip_address)')
      expect(chef_run).to render_file('/opt/consul.d/consul.hcl').with_content(/8.8.8.8/)
    end
  end

  context 'When the node is not a leader it uses the provided static_ip' do
    platform 'ubuntu', '18.04'
    override_attributes['attributes']['leader'] = false
    override_attributes['attributes']['static_ip'] = '9.9.9.9'
    automatic_attributes['ipaddress'] = '8.8.8.8'

    it 'uses the static ip as the join ip' do
      expect(chef_run).to create_template('/opt/consul.d/consul.hcl').with(
        source: 'consul.hcl.erb',
        owner: 'consul',
        group: 'consul',
        mode: '0755'
      )
      expect(chef_run).to render_file('/opt/consul.d/consul.hcl').with_content(/9.9.9.9/)
    end
  end

  context 'When the node is a server' do
    platform 'ubuntu', '18.04'
    override_attributes['attributes']['server'] = true

    it 'creates a server.hcl file' do
      expect(chef_run).to create_template('/opt/consul.d/server.hcl')
    end
  end

  context 'When the node is not a server' do
    platform 'ubuntu', '18.04'
    override_attributes['attributes']['server'] = false

    it 'does not create a server.hcl file' do
      expect(chef_run).to_not create_template('/opt/consul.d/server.hcl')
    end
  end
end
