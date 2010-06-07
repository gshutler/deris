require 'rubygems'
require 'fileutils'
require ::File.join(::File.dirname(__FILE__), 'file')

module Deris

  class Project
  
    def initialize(source)
      @source = source
      @content_directory = ::File.join(@source, '_src')
      @defaults = partials_from @content_directory
    end
    
    def write(output)
      FileUtils.rm_rf(output) if ::File.exists?(output)
      FileUtils.mkdir(output)
      
      File.new('index', @defaults).write output
            
      content_directories.each do |dir|
        partials = partials_from dir
        partials = @defaults.merge(partials)
        
        file_name = ::File.basename(dir)
        File.new(file_name, partials).write output
      end
    end
    
    private
    
    def content_directories
      content_directory_mask = ::File.join(@content_directory, '*')
      ::Dir[content_directory_mask].find_all do |dir|
        ::File.directory?(dir)
      end      
    end
  
    def partials_from(directory)
      partials = {}
      partial_file_mask = ::File.join(directory, '*.haml')
      partial_files = ::Dir.glob(partial_file_mask)
      
      partial_files.each do |file|
        file_sym = ::File.basename(file, '.haml').to_sym
        partials[file_sym] = ::File.new(file).read      
      end
      
      partials
    end
    
  end

end
