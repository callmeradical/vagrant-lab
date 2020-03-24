#
# Cookbook:: concourse
# Spec:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'concourse::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates a user called concourse' do
      expect(chef_run).to create_user('concourse')
    end

    it 'creates a group called concourse with the member concourse' do
      expect(chef_run).to create_group('concourse').with(
        members: ['concourse']
      )
    end

    it 'downloads a remote file for the concourse download' do 
      expect(chef_run).to create_remote_file_if_missing("#{Chef::Config[:file_cache_path]}/concourse.tar.gz")
    end

    it 'executes the command to unzip concourse to the correct location' do
      allow(File).to receieve(:exist?) { :true }
      allow(File).to receive(:exist?).with('/usr/local/bin/concourse').and_return(false)
      expect(chef_run).to run_execute('extract_concourse')
    end
  end
end
