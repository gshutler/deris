#!/usr/bin/env ruby

# work out base paths
current_dir = File.dirname(__FILE__)
root_dir = File.join(current_dir, '..')

# require the project class
require File.join(root_dir, 'lib', 'project')

# work out paths for test
project_path = File.join(current_dir, 'examples', 'project')
output_path = File.join(root_dir, 'output')

# create and write out project
project = Deris::Project.new project_path
project.write output_path
