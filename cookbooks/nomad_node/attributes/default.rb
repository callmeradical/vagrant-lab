# The version of nomad we want to install
default['attributes']['nomad_version'] = '0.10.2'

# This is just for readability
nomad_version = default['attributes']['nomad_version']
default['attributes']['nomad_url'] = "https://releases.hashicorp.com/nomad/#{nomad_version}/nomad_#{nomad_version}_linux_amd64.zip"
default['attributes']['server'] = true
default['attributes']['server_count'] = 3
default['attributes']['datacenter'] = 'dc1'
