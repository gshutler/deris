module Deris
    
  class Directory
    include PartialHasher
    include DirectoryWriter
    include SubdirectoryList
    
    attr_reader :file_name, :partials, :directory
      
    def initialize(directory, defaults = {}, depth = 0)
      @directory = directory
      @file_name = ::File.basename(directory)
      @partials = defaults.merge(partials_hash)
      @depth = depth
    end
        
    def sub_output(output)
      return ::File.join(output, @file_name), @depth + 1
    end
  
  end
  
end
