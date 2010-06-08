require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'project')
require 'rspec'

describe Deris::Project do
  
  let(:examples) { File.join(File.dirname(__FILE__), '..', 'examples') }
  let(:output) { File.join(File.dirname(__FILE__), '..', '..', 'output') }

  context 'with nested templates' do
    
    let(:project) { Deris::Project.new(File.join(examples, 'project')) }
    let(:morrisons_directory) { File.join(output, 'morrisons') }
    
    before do
      project.write(output)
    end

    it 'should create the morrisons directory' do
      File.exist?(morrisons_directory).should be_true
    end
    
    it 'should create a file called "bread.html" in the morrisons directory' do
      File.exist?(File.join(morrisons_directory, 'bread.html')).should be_true
    end
    
    it 'should have the phrase "Freshly baked in store, every day" in "bread.html"' do
      # don't know how to check the contents of a file off the top of my head
      false.should be_true
    end
  
  end  
  
end
