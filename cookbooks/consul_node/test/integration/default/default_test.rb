# InSpec test for recipe consul_node::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root'), :skip do
    it { should exist }
  end
end

# This is an example test, replace it with your own test.
describe port(80), :skip do
  it { should_not be_listening }
end

describe user('consul') do
  its('groups') { should include 'consul' }
end

describe group('consul') do
  it { should exist }
  its('members') { should include 'consul' }
end

describe package('unzip') do
  it { should be_installed }
end

describe file('/tmp/kitchen/cache/consul.zip') do
  it { should exist }
end

describe file('/usr/local/bin/consul') do
  it { should exist }
end

describe directory('/opt/consul.d') do
  it { should exist }
  its('group') { should eq 'consul' }
end

describe directory('/opt/consul') do
  it { should exist }
  its('group') { should eq 'consul' }
end

describe file('/etc/systemd/system/consul.service') do
  it { should exist }
  its('content') { should match /consul agent/ }
  its('mode') { should cmp '0600' }
end

describe file('/opt/consul.d/consul.hcl') do
  it { should exist }
  its('mode') { should cmp '0600' }
end

describe file('/opt/consul.d/server.hcl') do
  it { should exist }
  its('mode') { should cmp '0600' }
end

describe file('/etc/systemd/resolved.conf') do
  it { should exist }
  its('content') { should match /domains=~consul/ }

describe service('consul') do
  it { should be_running }
end
