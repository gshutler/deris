#!/usr/bin/env ruby

require 'rubygems'
require 'fileutils'
require 'haml'

module Deris

  def self.render(template)
    if template.is_a? Symbol
      template = template.to_s
    else
      template = File[template]
    end
    haml_engine = Haml::Engine.new(template)
    haml_engine.render(self)
  end
  
  private
  
  def self.read_file(filename)
    f = File.open(filename, "r") 
    data = ''
    f.each_line do |line|
      data += line
    end
    data   
  end

end

if __FILE__ == $0
  puts Deris::render(ARGV[0])
end

