#!/usr/bin/env ruby

require 'fileutils'
require File.join(File.dirname(__FILE__), 'src', 'project')


if File.directory? ARGV[0]
  Deris::Project.new(ARGV[0]).write(ARGV[1]) 
else
  name = File.basename(ARGV[0])
  puts Deris::File.new(name).render(ARGV[0])
end

