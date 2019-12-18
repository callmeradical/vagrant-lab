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

describe package('docker-ce') do
  it { should be_installed }
end

describe package('apt-transport-https') do
  it { should be_installed }
end

describe file('/tmp/blob') do
  it { should exist }
end

describe user('vagrant') do 
  its('groups') { should include 'vagrant' }
end
