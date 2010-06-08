require 'rubygems'
require 'fileutils'

module Deris
  
  module SubdirectoryList
  
    def sub_directories
      unless respond_to?(:directory)
        raise 'need to respond to  "directory" to list sub directories'
      end
      
      sub_directory_mask = ::File.join(directory, '*')
      ::Dir[sub_directory_mask].find_all do |dir|
        ::File.directory?(dir)
      end
    end
    
  end

end