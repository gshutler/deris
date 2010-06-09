require 'rubygems'
require 'rake/gempackagetask'

namespace :jeweler do
	require 'jeweler'	
	Jeweler::Tasks.new do |gs|
	  gs.name      = "deris"
    gs.version   = "0.1.3"
    gs.author    = "Garry Shutler"
    gs.email     = "garry@robustsoftware.co.uk"
    
    gs.homepage      = "http://github.com/gshutler/deris"  
    gs.summary       = "Simple documentation creation engine based on HAML"
    gs.description   = "Simple documentation creation engine based on HAML"
    
    gs.files         = FileList['lib/*.rb']
    gs.test_files    = FileList['tests/**/*']
    
    gs.require_path  = "lib"
    
    gs.add_dependency("haml", ">=2.2.0")
    gs.add_dependency("rspec", ">=1.3.0")
	end
end

# load all rake files in the project
rakefile_mask = File.join(File.expand_path(File.dirname(__FILE__)), '**', '*.rake')
Dir.glob(rakefile_mask).each {|f| load f }
