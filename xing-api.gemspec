require File.expand_path('../lib/xing/version.rb', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'xing-api'
  s.summary     = 'Ruby wrapper for the XING API'
  s.description = 'Provides calls to every endpoint of the XING API. Parses responses and handles errors.'
  s.email       = ['api-support@xing.com']
  s.authors     = ['Mark Schmidt', 'Johannes Strampe']
  s.homepage    = 'https://source.xing.com/xws/ruby_api_wrapper'
  s.licenses    = ['MIT']

  s.add_dependency 'oauth', '~>0.4.7'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'debugger'

  s.version                   = Xing::VERSION
  s.platform                  = Gem::Platform::RUBY
  s.files                     = Dir.glob('{lib}/**/*')
  s.require_paths             = ['lib']
  s.required_rubygems_version = '>= 1.3.5'
end
