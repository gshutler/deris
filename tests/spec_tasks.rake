require 'rake'
require 'rubygems'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |spec|
  spec.pattern = File.join(File.dirname(__FILE__), '*_specs', '**', '*.rb')
end

