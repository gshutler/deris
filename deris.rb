#!/usr/bin/env ruby

require 'rubygems'
require 'fileutils'
require 'haml'
require 'rdiscount'

class Deris

  def self.generate_site(directory)
    defaults = {}
    source_directory = File.join(directory, '_source')
    
    defaults = partials_from source_directory
    
    File.open(File.join(directory, 'index.html'), 'w+') do |file|
      file.write Deris.new(defaults).render
    end
    
    source_directory_mask = File.join(source_directory, '*')
    source_directories = Dir[source_directory_mask].find_all do |dir|
      File.directory?(dir)
    end
    
    source_directories.each do |dir|
      partials = partials_from dir
      partials = defaults.merge(partials)
      
      File.open(File.join(directory, "#{File.basename(dir)}.html"), 'w+') do |file|
        file.write Deris.new(partials).render
      end 
    end
  end
  
  def initialize(partials = {})
    @partials = partials
  end
  
  def partial(template)
    if template.is_a? Symbol
      template = @partials[template]
    end
    render(template)
  end
  
  def render(template = nil)
    if template.nil?
      template = @partials[:layout]
    else
      template = File.new(template).read if File.exist?(template)
    end
    haml_engine = Haml::Engine.new(template)
    haml_engine.render(self)
  end
  
  def set_partial(symbol, template)
    @partials[symbol] = render(template)
  end
  
  private 
  
  def self.partials_from(directory)
    partials = {}
    partial_file_mask = File.join(directory, '*.haml')
    partial_files = Dir.glob(partial_file_mask)
    
    partial_files.each do |file|
      file_sym = File.basename(file, '.haml').to_sym
      partials[file_sym] = File.new(file).read      
    end
    
    partials
  end

end

if __FILE__ == $0
  if File.directory? ARGV[0]
    Deris::generate_site(ARGV[0]) 
  else
    puts Deris.new.render(ARGV[0])
  end
end

