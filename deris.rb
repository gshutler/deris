#!/usr/bin/env ruby

require 'fileutils'
require File.join(File.dirname(__FILE__), 'src', 'project')


if File.directory? ARGV[0]
  # ./deris.rb <source> <output>
  
  # Example usage
  # ./deris.rb examples/project/ output/  
  Deris::Project.new(ARGV[0]).write(ARGV[1]) 
else
  # ./deris.rb <file>
  
  # Example usage
  # ./deris.rb examples/file/initial.haml
  
  # This method is likely to be removed as there is no need for it but it was
  # part of the development process
  name = File.basename(ARGV[0], ".haml")
  puts Deris::File.new(name).render(ARGV[0])
end

