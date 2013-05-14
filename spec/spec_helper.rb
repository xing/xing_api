$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

require 'xing'
require 'mocha/api'
require 'rspec'

require 'shared_examples'

RSpec.configure do |config|
  config.mock_framework = :mocha
end
