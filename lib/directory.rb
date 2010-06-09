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
