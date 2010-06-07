require 'rubygems'
require 'fileutils'
require ::File.join(::File.dirname(__FILE__), 'file')

module Deris

  class Project
  
    def initialize(source)
      @source = source
      @source_directory = ::File.join(@source, '_src')
      @defaults = partials_from @source_directory
    end
    
    def write(output)
      # recreate the output directory
      FileUtils.rm_rf(output) if ::File.exists?(output)
      FileUtils.mkdir(output)
      
      # find and copy all static content
      static_content_mask = ::File.join(@source, "**")
      static_content = Dir[static_content_mask].reject{|path| path =~ /_src$/}      
      static_content.each{|path| FileUtils.cp_r(path, output)}
      
      # generate the index page from defaults
      File.new('index', @defaults).write output

      # generate the other pages of the site from sub-directories
      source_directories.each do |dir|
        partials = partials_from dir
        partials = @defaults.merge(partials)        
        file_name = ::File.basename(dir)
        File.new(file_name, partials).write output
      end
    end
    
    private
    
    def source_directories
      source_directory_mask = ::File.join(@source_directory, '*')
      ::Dir[source_directory_mask].find_all do |dir|
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
