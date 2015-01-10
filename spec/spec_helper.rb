$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

require 'xing_api'
require 'mocha/api'
require 'rspec'

require 'shared_examples'

RSpec.configure do |config|
  config.mock_framework = :mocha
end

def expect_request(*expected_params)
  XingApi::Client.any_instance.expects(:request).with do |*params|
    expect(params.count).to eql(expected_params.count),
      "Expected request with #{expected_params.count} parameters but got #{params.count}"

    params.length.times { |i| expect(params[i]).to eql(expected_params[i]) }
  end
end

def expect_request_with_body(*expected_params)
  XingApi::Client.any_instance.expects(:request_with_body).with do |*params|
    expect(params.count).to eql(expected_params.count),
      "Expected request with #{expected_params.count} parameters but got #{params.count}"

    params.length.times { |i| expect(params[i]).to eql(expected_params[i]) }
  end
end
