#
# Cookbook:: nomad_node
# Spec:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'nomad_node::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates the nomad user and group' do
      expect(chef_run).to create_user('nomad').with(
        group: 'nomad'
      )
      expect(chef_run).to create_group('nomad')
    end

    it 'downloads and installs nomad' do
      expect(chef_run).to create_if_missing_remote_file("#{Chef::Config[:file_cache_path]}/nomad.zip")
      expect(chef_run).to run_execute('install nomad')
      expect(chef_run).to create_directory('/opt/nomad.d')
      expect(chef_run).to create_directory('/opt/nomad')
      expect(chef_run).to create_template('/opt/nomad.d/server.hcl')
      expect(chef_run).to create_template('/opt/nomad.d/nomad.hcl')
    end

    context 'it can be a client' do
      platform 'ubuntu', '18.04'
      override_attributes['attributes']['server'] = false

      it 'renders the nomad.hcl' do
        expect(chef_run).to create_template('/opt/nomad.d/nomad.hcl')
        expect(chef_run).to render_file('/opt/nomad.d/nomad.hcl').with_content(/enabled = true/)
        expect(chef_run).to render_file('/opt/nomad.d/nomad.hcl').with_content(/client/)
      end
    end

    it 'starts the nomad servce' do
      expect(chef_run).to start_service('nomad')
    end
  end
end
