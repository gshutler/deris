Dir.glob(File.join(File.expand_path(File.dirname(__FILE__)), 'file.rb')).each {|f| require f }
Dir.glob(File.join(File.expand_path(File.dirname(__FILE__)), 'project.rb')).each {|f| require f }
