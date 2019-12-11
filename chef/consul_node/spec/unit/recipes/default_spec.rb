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

    it 'adds required repositories' do
      expect(chef_run).to add_apt_repository('docker')
    end

    it 'installs some additional packages' do
      expect(chef_run).to install_package('curl')
      expect(chef_run).to install_package('ca-certificates')
      expect(chef_run).to install_package('gnupg-agent')
      expect(chef_run).to install_package('software-properties-common')
      expect(chef_run).to install_package('apt-transport-https')
      expect(chef_run).to install_package('docker-ce')
      expect(chef_run).to install_package('docker-ce-cli')
      expect(chef_run).to install_package('containerd.io')
    end

    it 'modifiers the docker group for the vagrant user' do
      expect(chef_run).to modify_group('docker')
    end

    it 'downloads consul from hashicorp' do
      expect(chef_run).to create_remote_file_if_missing('/tmp/consul.zip')
      expect(chef_run).to
    end
  end
end