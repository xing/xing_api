$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'xing_api/version'

Gem::Specification.new do |s|
  s.name        = 'xing_api'
  s.summary     = 'Official Ruby wrapper for the XING API'
  s.description = <<-TEXT
    Provides access to every endpoint of the XING API.
    Takes care of oauth, reponse parsing and simplifies error handling.
    You can get the required consumer_key and consumer_secret at https://dev.xing.com
  TEXT
  s.email       = ['api-support@xing.com']
  s.authors     = ['Mark Schmidt', 'Johannes Strampe']
  s.homepage    = 'https://github.com/xing/xing_api'
  s.licenses    = ['MIT']

  s.add_dependency 'oauth', '~>0.4.7'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rubocop'

  s.version                   = XingApi::VERSION
  s.platform                  = Gem::Platform::RUBY
  s.files                     = Dir.glob('{lib}/**/*')
  s.require_paths             = ['lib']
  s.required_rubygems_version = '>= 1.3.5'
end
