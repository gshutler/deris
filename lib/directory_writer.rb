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
        sub_output_dir, sub_depth = sub_output(output)
        Directory.new(dir, partials, sub_depth).write(sub_output_dir)
      end
    end
    
    def write_file(output)
      unless respond_to?(:file_name) and respond_to?(:partials)
        raise 'need to respond to "file_name" and "partials" to use write_file' 
      end
      
      File.new(file_name, partials, @depth).write(output)
    end
    
  end
  
end
