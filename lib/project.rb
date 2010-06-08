require 'rubygems'
require 'fileutils'
require ::File.join(::File.dirname(__FILE__), 'file')

module Deris

  module PartialHasher
    
    def partials_hash
      raise 'need @directory value to use partials_hash' unless @directory
      partials = {}
      partial_file_mask = ::File.join(@directory, '*.haml')
      partial_files = ::Dir.glob(partial_file_mask)
      
      partial_files.each do |file|
        file_sym = ::File.basename(file, '.haml').to_sym
        partials[file_sym] = ::File.new(file).read      
      end
      
      partials      
    end
    
  end
  
  module DirectoryWriter
  
    def write_file(output)
      raise 'need @file_name and @partials values to use write_file' unless @file_name and @partials
      File.new(@file_name, @partials).write output
    end
  
  end
  
  module SubdirectoryList
  
    def sub_directories
      raise 'need @directory value to use sub_directories' unless @directory
      sub_directory_mask = ::File.join(@directory, '*')
      ::Dir[sub_directory_mask].find_all do |dir|
        ::File.directory?(dir)
      end
    end
    
  end

  class Directory
    include PartialHasher
    include DirectoryWriter
    include SubdirectoryList
      
    def initialize(directory, defaults = {})
      @directory = directory
      @file_name = ::File.basename(directory)
      @partials = defaults.merge(partials_hash)
    end
    
    def write(output)
      # write out the content from this directory
      write_file output
      
      sub_output = ::File.join(output, @file_name)
      sub_directories.each do |dir|
        Directory.new(dir, @partials).write(sub_output)
      end
    end
  
  end

  class Project
    include PartialHasher
    include DirectoryWriter
    include SubdirectoryList
  
    def initialize(source, defaults = {})
      @source = source
      @file_name = 'index'
      @directory = ::File.join(@source, '_src')
      @partials = defaults.merge(partials_hash)
    end
    
    def write(output)
      # recreate the output directory
      FileUtils.rm_rf(output) if ::File.exists?(output)
      FileUtils.mkdir(output)
      
      # find and copy all static content
      static_content_mask = ::File.join(@source, "**")
      static_content = Dir[static_content_mask].reject{|path| path =~ /_src$/}      
      static_content.each{|path| FileUtils.cp_r(path, output)}
      
      # generate the root page
      write_file output
      
      # generate the other pages of the site from sub-directories
      sub_directories.each do |dir|
        Directory.new(dir, @partials).write(output)
      end
    end
        
  end

end
