require 'rubygems'
require 'fileutils'
require ::File.join(::File.dirname(__FILE__), 'partial_hasher')
require ::File.join(::File.dirname(__FILE__), 'directory_writer')
require ::File.join(::File.dirname(__FILE__), 'subdirectory_list')

module Deris
    
  class Directory
    include PartialHasher
    include DirectoryWriter
    include SubdirectoryList
    
    attr_reader :file_name, :partials, :directory
      
    def initialize(directory, defaults = {})
      @directory = directory
      @file_name = ::File.basename(directory)
      @partials = defaults.merge(partials_hash)
    end
        
    def sub_output(output)
      ::File.join(output, @file_name)
    end
  
  end
  
end