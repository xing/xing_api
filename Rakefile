require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = '--color'
end

RuboCop::RakeTask.new
task default: [:rubocop, :spec]
