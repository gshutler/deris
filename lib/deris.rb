require 'rubygems'
require 'fileutils'
require 'haml'

# load the files in dependency order to avoid loads of require statements in each file
['subdirectory_list', 'partial_hasher', 'file', 'directory_writer', 'directory', 'project'].each do |f|
  require File.join(File.expand_path(File.dirname(__FILE__)), "#{f}.rb")
end
