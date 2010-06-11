require 'rake'
require 'rubygems'
require 'rspec/core/rake_task'

SPEC_PATTERN = File.join(File.dirname(__FILE__), '*_specs', '**', '*.rb')

RSpec::Core::RakeTask.new do |spec|
  spec.pattern = SPEC_PATTERN
end

namespace :spec do
  
  task :doc do
    cmd = ['spec']
    cmd << '-f n'
    cmd += FileList[SPEC_PATTERN].to_a
    cmd = cmd.join(' ')
    system cmd
  end
  

end
