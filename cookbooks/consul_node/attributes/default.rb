consul_version = '1.6.2'
default['attributes']['consul_url'] = "https://releases.hashicorp.com/consul/#{consul_version}/consul_#{consul_version}_linux_amd64.zip"
default['attributes']['static_ip'] = '10.0.2.15'
default['attributes']['server'] = true
default['attributes']['leader'] = true
default['attributes']['server_count'] = 1
default['attributes']['subnet'] = '10.0.2.0/24'
