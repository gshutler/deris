require 'rubygems'
require 'rake/gempackagetask'

namespace :jeweler do
	require 'jeweler'	
	Jeweler::Tasks.new do |gs|
	  gs.name      = "deris"
    gs.version   = "0.1.2"
    gs.author    = "Garry Shutler"
    gs.email     = "garry@robustsoftware.co.uk"
    
    gs.homepage      = "http://github.com/gshutler/deris"  
    gs.summary       = "Simple documentation creation engine based on HAML"
    gs.description   = "Simple documentation creation engine based on HAML"
    
    gs.files         = FileList['lib/*.rb'].to_a
    gs.require_path  = "lib"
    gs.add_dependency("haml", ">=2.2.0")
	end
end