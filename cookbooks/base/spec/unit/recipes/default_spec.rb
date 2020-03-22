#
# Cookbook:: base
# Spec:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'base::default' do
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
      expect(chef_run).to install_package('unzip')
      expect(chef_run).to install_package('jq')
      expect(chef_run).to install_package('htop')
    end

    it 'modifiers the docker group for the vagrant user' do
      expect(chef_run).to modify_group('docker')
    end

    it 'finds the private ip address and exports the NOMAD_ADDR' do
      expect(chef_run).to run_ruby_block('find_private_ip_address')
      expect(chef_run).to create_template('/home/vagrant/.profile')
      expect(chef_run).to create_file('/tmp/test')
    end
  end
end
