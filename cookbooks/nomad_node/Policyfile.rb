# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile.html

# A name that describes what the system you're building with Chef does.
name 'nomad_node'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'consul_node::default', 'nomad_node::default'

# Specify a custom source for a single cookbook:
cookbook 'consul_node', path: '../consul_node'
cookbook 'nomad_node', path: '.'
