require 'chefspec'
require 'chefspec/policyfile'

RSpec.configure do |config|
  config.platform = 'ubuntu'
  config.version = '18.04'
end
