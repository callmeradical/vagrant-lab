# InSpec test for recipe nomad_node::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

describe user('nomad') do
  it { should exist }
end

describe group('nomad') do
  it { should exist }
  its('members') { should include 'nomad' }
end

describe file('/tmp/kitchen/cache/nomad.zip') do
  it { should exist }
  its('owner') { should eq 'nomad' }
end

describe file('/usr/local/bin/nomad') do
  it { should exist }
end

describe directory('/opt/nomad') do
  it { should exist }
  its('owner') { should eq 'nomad' }
  its('group') { should eq 'nomad' }
  its('mode') { should cmp '0700' }
end

describe directory('/opt/nomad.d') do
  it { should exist }
  its('owner') { should eq 'nomad' }
  its('group') { should eq 'nomad' }
  its('mode') { should cmp '0700' }
end

describe file('/etc/systemd/system/nomad.service') do
  it { should exist }
  its('mode') { should cmp '0600' }
end

describe service('nomad') do
  it { should be_running }
end

describe port(4646) do
  it { should be_listening }
end
