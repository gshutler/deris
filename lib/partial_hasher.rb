module Deris

  module PartialHasher
    
    def partials_hash
      unless respond_to?(:directory)
        raise 'need to response to  "directory" to create a hash of partials' 
      end
      
      partials = {}
      partial_file_mask = ::File.join(directory, '*.haml')
      partial_files = ::Dir.glob(partial_file_mask)
      
      partial_files.each do |file|
        file_sym = ::File.basename(file, '.haml').to_sym
        partials[file_sym] = ::File.new(file).read      
      end

      # apply the convention where a partial with the same name as the file
      # being output is set as the content partial unless it already exists
      if !partials[:content] and partials[@file_name.to_sym]
        partials[:content] = partials[@file_name.to_sym]
      end
            
      partials      
    end
    
  end
  
end
