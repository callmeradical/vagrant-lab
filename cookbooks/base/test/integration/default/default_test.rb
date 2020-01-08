# InSpec test for recipe base::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root'), :skip do
    it { should exist }
  end

  packages = %w(
    curl unzip gnupg-agent
    software-properties-common apt-transport-https
    docker-ce docker-ce-cli containerd.io)

  packages.each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end

  describe group('docker') do
    it { should exist }
    its('members') { should include 'vagrant' }
  end

  describe file('/home/vagrant/.profile') do
    it { should exist }
    its('content') { should match /export NOMAD_ADDR=/ }
  end
end

# This is an example test, replace it with your own test.
describe port(80), :skip do
  it { should_not be_listening }
end
