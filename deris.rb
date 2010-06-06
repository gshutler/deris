#!/usr/bin/env ruby

require 'rubygems'
require 'fileutils'
require 'haml'

class Deris

  attr_accessor :partials
  
  def initialize()
    @partials = {}
  end
  
  def partial(template)
    if template.is_a? Symbol
      @partials[template]
    else
      render(template)
    end
  end
  
  def render(template)
    template = File.new(template).read if File.exist?(template)
    haml_engine = Haml::Engine.new(template)
    haml_engine.render(self)
  end

end

if __FILE__ == $0
  puts Deris.new.render(ARGV[0])
end

