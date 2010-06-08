require 'rubygems'
require 'fileutils'
require ::File.join(::File.dirname(__FILE__), 'directory')
require ::File.join(::File.dirname(__FILE__), 'partial_hasher')
require ::File.join(::File.dirname(__FILE__), 'directory_writer')
require ::File.join(::File.dirname(__FILE__), 'subdirectory_list')

module Deris

  class Project
    include PartialHasher
    include DirectoryWriter
    include SubdirectoryList
    
    attr_reader :file_name, :partials, :directory
  
    def initialize(source, defaults = {})
      @source = source
      @file_name = 'index'
      @directory = ::File.join(@source, '_src')
      @partials = defaults.merge(partials_hash)
    end
    
    def write(output)
      # adds additional behaviour on top of the DirectoryWriter mixin
      
      # recreate the output directory
      FileUtils.rm_rf(output) if ::File.exists?(output)
      FileUtils.mkdir(output)
      
      # find and copy all static content
      static_content_mask = ::File.join(@source, "**")
      static_content = Dir[static_content_mask].reject{|path| path =~ /_src$/}      
      static_content.each{|path| FileUtils.cp_r(path, output)}
      
      # call the DirectoryWriter mixin
      super
    end
    
    def sub_output(output)
      output
    end
        
  end

end
