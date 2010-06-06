#!/usr/bin/env ruby

# Inspired by
# http://www.pragmaticautomation.com/cgi-bin/pragauto.cgi/Monitor/StakingOutFileChanges.rdoc

require 'fileutils'

# ./autoderis.rb <source> <ouput>

# Example usage
# ./autoderis.rb example/ output/

def last_altered_file
  files = File.join(ARGV[0], '**', '*')
  files_in_altered_order = Dir.glob(files).sort do |left, right|
    File.mtime(left) <=> File.mtime(right)
  end
  files_in_altered_order.last
end

deris = File.join(File.dirname(__FILE__), 'deris.rb')

loop do
  last_generated = File.mtime(ARGV[1])
  last_altered = last_altered_file
  if last_generated < File.mtime(last_altered)
    puts '!'
    puts "#{last_altered} changed - generating output"
    load deris
  else
    print '.'
    STDOUT.flush
  end
  sleep 2
end

