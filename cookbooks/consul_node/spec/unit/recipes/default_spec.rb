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

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'downloads consul from hashicorp' do
      expect(chef_run).to create_remote_file_if_missing('/tmp/consul.zip')
      expect(chef_run).to run_execute('extract_consul')
    end
  end
end
