require 'rubygems'
require 'fileutils'
require 'haml'
require 'rdiscount'

module Deris

  class File
    
    def initialize(name = 'index', partials = {})
      @name = name
      @partials = partials
    end
    
    def write(directory)
      output_path = ::File.join(directory, "#{@name}.html")
      ::File.open(output_path, 'w+') do |file|
        file.write render
      end
    end
    
    def render(template = nil)
      if template.nil?
        template = @partials[:layout]
      else
        template = ::File.new(template).read if ::File.exist?(template)
      end
      haml_engine = Haml::Engine.new(template)
      haml_engine.render(self)
    end
    
    def partial(template)
      if template.is_a? Symbol
        template = @partials[template] || ''
      end
      render(template)
    end
    
  end

end
