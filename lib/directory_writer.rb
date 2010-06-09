module Deris
  
  module DirectoryWriter
    
    def write(output)
      unless respond_to?(:sub_directories) and respond_to?(:partials) and respond_to?(:sub_output)
        raise 'need to respond to "sub directories", "partials" and "sub_output" to write'
      end
      
      # write out the content from this directory
      write_file output

      # write out the sub directories
      sub_directories.each do |dir|        
        Directory.new(dir, partials).write(sub_output(output))
      end
    end
    
    def write_file(output)
      unless respond_to?(:file_name) and respond_to?(:partials)
        raise 'need to respond to "file_name" and "partials" to use write_file' 
      end
      
      File.new(file_name, partials).write output
    end
    
  end
  
end
